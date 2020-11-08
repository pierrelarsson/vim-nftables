" Vim syntax file
" Language: nftables
" Maintainer: Pierre Larsson <pierre.rj.larsson@gmail.com>
" Last Change: 2020 Nov 08

if exists('b:current_syntax')
    finish
endif

syn match   nftSynError         contained   "\S\+\ze\W"
syn keyword nftCommand          add create flush delete rename list
syn keyword nftOperator         eq ne lt gt le ge xor or and
syn match   nftInclude          "^\s*\zsinclude"
syn match   nftDefine           "^\s*\zsdefine" skipwhite nextgroup=nftIdentifier
syn match   nftNumeric          "\<\d\+\>"
syn match   nftNumeric          "\<0x[[:xdigit:]]\+\>"
syn match   nftAddress          "[[:xdigit:]:]\+:[[:xdigit:]:/]*"
syn match   nftAddress          "[[:digit:]]\+\.[[:digit:]./]*"
syn match   nftIdentifier       contained   "[a-zA-Z_.][a-zA-Z0-9_/.-]*"
syn match   nftVariable         "[$@][a-zA-Z_.][a-zA-Z0-9_/.-]*"
syn region  nftString           oneline     start=/"/ end=/"/
syn region  nftComment          oneline     start="^\s*\zs#" end="$"
syn match   nftInterface        "\<en[os][[:digit:].]\+\>"
syn match   nftInterface        "\<enp\d\+s[[:digit:].]\+\>"
syn match   nftInterface        "\<eth[[:digit:].]\+\>"

syn keyword nftContainer        table       skipwhite nextgroup=nftTableFamily
syn keyword nftContainer        chain       skipwhite nextgroup=nftIdentifier
syn keyword nftContainer        secmark     skipwhite nextgroup=nftIdentifier
syn keyword nftContainer        map         skipwhite nextgroup=nftIdentifier
syn keyword nftContainer        set         skipwhite nextgroup=nftIdentifier

syn keyword nftHeader           type        skipwhite nextgroup=nftChainType,nftSetType
syn keyword nftHeader           hook        skipwhite nextgroup=nftChainHook
syn keyword nftHeader           priority    skipwhite nextgroup=nftChainPriority
syn keyword nftHeader           policy      skipwhite nextgroup=nftChainPolicy
syn keyword nftHeader           protocol    skipwhite nextgroup=nftProtocols
syn keyword nftHeader           l3proto     skipwhite nextgroup=nftTableFamily
syn keyword nftHeader           device      skipwhite nextgroup=nftInterface

syn keyword nftSetType          contained   ipv4_addr ipv6_addr ether_addr inet_proto inet_service mark
syn keyword nftChainType        contained   filter nat route
syn keyword nftChainHook        contained   input output forward prerouting postrouting ingress
syn keyword nftChainPolicy      contained   accept drop
syn keyword nftChainPriority    contained   raw mangle filter security srcnat dstnat out
syn keyword nftTableFamily      contained   ip ip6 inet arp bridge netdev skipwhite nextgroup=nftIdentifier
syn keyword nftReference        vmap
syn keyword nftReference        contained   set map

" Protocols
syn keyword nftProtocols        contained   ah arp comp dccp esp ether icmp icmpv6 igmp ip ip6 sctp tcp th udp udplite vlan ipv4 ipv6
syn match   nftRaw              "@\(th\|nh\|ll\)\ze,"
syn keyword nftRaw              th skipwhite nextgroup=nftAh,nftArp,nftComp,nftDccp,nftEsp,nftEther,nftIcmp,nftIcmpv6,nftIgmp,nftIp,nftIp6,nftSctp,nftTcp,nftUdp,nftUdplite,nftVlan

syn keyword nftProtocol         ah          skipwhite nextgroup=nftAh
syn keyword nftAh               contained   hdrlength reserved spi sequence skipwhite nextgroup=nftReference
syn keyword nftAh               contained   nexthdr nextgroup=nftReference,nftProtocols

syn keyword nftProtocol         arp         skipwhite nextgroup=nftArp
syn keyword nftArp              contained   htype ptype hlen plen operation skipwhite nextgroup=nftReference
syn match   nftArp              contained   "\<[sd]addr \(ether\|ip\)\>" skipwhite nextgroup=nftReference

syn keyword nftProtocol         comp        skipwhite nextgroup=nftComp
syn keyword nftComp             contained   flags cpi skipwhite nextgroup=nftReference
syn keyword nftComp             contained   nexthdr skipwhite nextgroup=nftReference,nftProtocols

syn keyword nftProtocol         dccp        skipwhite nextgroup=nftDccp
syn keyword nftDccp             contained   sport dport skipwhite nextgroup=nftReference

syn keyword nftProtocol         esp         skipwhite nextgroup=nftEsp
syn keyword nftEsp              contained   spi sequence skipwhite nextgroup=nftReference

syn keyword nftProtocol         ether       skipwhite nextgroup=nftEther
syn keyword nftEther            contained   daddr saddr type skipwhite nextgroup=nftReference

syn keyword nftProtocol         icmp        skipwhite nextgroup=nftIcmp
syn keyword nftIcmp             contained   type code checksum id sequence gateway mtu skipwhite nextgroup=nftReference

syn keyword nftProtocol         icmpv6      skipwhite nextgroup=nftIcmpv6
syn keyword nftIcmpv6           contained   type code checksum parameter-problem packet-too-big id sequence max-delay skipwhite nextgroup=nftReference

syn keyword nftProtocol         igmp        skipwhite nextgroup=nftIgmp
syn keyword nftIgmp             contained   type mrt checksum group skipwhite nextgroup=nftReference

syn match   nftProtocol         "\<ip\>"    skipwhite nextgroup=nftIp
syn keyword nftIp               contained   version hdrlength dscp ecn length id frag-off ttl checksum saddr daddr skipwhite nextgroup=nftReference
syn keyword nftIp               contained   protocol skipwhite nextgroup=nftReference,nftProtocols

syn keyword nftProtocol         ip6         skipwhite nextgroup=nftIp6
syn keyword nftIp6              contained   version dscp ecn flowlabel length hoplimit saddr daddr skipwhite nextgroup=nftReference
syn keyword nftIp6              contained   nexthdr skipwhite nextgroup=nftReference,nftProtocols

syn keyword nftProtocol         sctp        skipwhite nextgroup=nftSctp
syn keyword nftSctp             contained   sport dport vtag checksum skipwhite nextgroup=nftReference

syn match   nftProtocol         "\<tcp\>"   skipwhite nextgroup=nftTcp
syn keyword nftTcp              contained   sport dport sequence ackseq doff reserved flags window checksum urgptr skipwhite nextgroup=nftReference

syn keyword nftProtocol         udp         skipwhite nextgroup=nftUdp
syn keyword nftUdp              contained   sport dport length checksum skipwhite nextgroup=nftReference

syn keyword nftProtocol         udplite     skipwhite nextgroup=nftUdplite
syn keyword nftUdplite          contained   sport dport checksum skipwhite nextgroup=nftReference

syn keyword nftProtocol         vlan        skipwhite nextgroup=nftVlan
syn keyword nftVlan             contained   id cfi pcp type skipwhite nextgroup=nftReference

" Extensions
syn keyword nftExtension        frag        skipwhite nextgroup=nftFrag
syn keyword nftFrag             contained   nexthdr frag-off more-fragments id

syn keyword nftExtension        dst         skipwhite nextgroup=nftDst
syn keyword nftDst              contained   nexthdr hdrlength

syn keyword nftExtension        hbh         skipwhite nextgroup=nftHbh
syn keyword nftHbh              contained   nexthdr hdrlength

syn keyword nftExtension        rt          skipwhite nextgroup=nftRt
syn keyword nftRt               contained   nexthdr hdrlength type seg-left

syn keyword nftExtension        mh          skipwhite nextgroup=nftMh
syn keyword nftMh               contained   nexthdr hdrlength checksum type

syn keyword nftExtension        srh         skipwhite nextgroup=nftSrh
syn keyword nftSrh              contained   flags tag sid seg-left

syn match   nftExtension        "\<tcp\s\+option\>" skipwhite nextgroup=nftTcpOption
syn keyword nftTcpOption        contained   eol noop maxseg window sack-permitted sack sack0 sack1 sack2 sack3 timestamp

syn match   nftExtension        "\<ip\s\+option\>" skipwhite nextgroup=nftIpOption
syn keyword nftIpOption         contained   lsrr ra rr ssrr

syn keyword nftExtension        exthdr      skipwhite nextgroup=nftExthdr
syn keyword nftExthdr           contained   hbh frag rt dst mh

syn match   nftExtension        "\<ip\s\+option\>" skipwhite nextgroup=nftIpOption
syn keyword nftIpOption         contained   lsrr ra rr ssrr

" Functions
syn keyword nftFunction         numgen      skipwhite nextgroup=nftNumgen
syn keyword nftNumgen           contained   inc random

syn keyword nftFunction         symhash jhash

syn keyword nftFunction         fib         skipwhite nextgroup=nftFib
syn keyword nftFib              contained   saddr daddr mark iif oif

syn match   nftFunction         /\<ct\>/    skipwhite nextgroup=nftConntackDir,nftConntack
syn match   nftContainer        /\<ct\s\+\(helper\|timeout\|expectation\)\>/ skipwhite nextgroup=nftIdentifier
syn match   nftFunction         /\<ct\s\+\(helper\|timeout\|expectation\)\s\+set\>/ contains=nftFunction,nftConntack,nftReference
syn keyword nftConntackDir      original reply skipwhite nextgroup=nftConntack
syn keyword nftConntack         contained   state direction status mark expiration helper saddr daddr proto-src proto-dst label bytes packets avgpkt zone event secmark id skipwhite nextgroup=nftReference
syn keyword nftConntack         contained   protocol l3proto skipwhite nextgroup=nftReference,nftProtocols

syn keyword nftFunction         meta        skipwhite nextgroup=nftMetaQualified,nftMetaUnqualified
syn keyword nftMetaQualified    contained   length priority random secmark ibrpvid ibrvproto skipwhite nextgroup=nftReference
syn keyword nftMetaQualified    contained   nfproto l4proto protocol skipwhite nextgroup=nftProtocols,nftReference
syn keyword nftMetaUnqualified  mark iif iifname iiftype oif oifname oiftype skuid skgid nftrace rtclassid ibrname obrname pkttype cpu iifgroup oifgroup cgroup ipsec secpath time day hour iifkind oifkind obriport ibriport skipwhite nextgroup=nftReference

" Statements
syn keyword nftTerminalStmt     accept drop queue continue return
syn keyword nftTerminalStmt     jump goto
syn keyword nftTerminalStmt     dnat snat masquerade redirect       skipwhite nextgroup=nftNatProto,nftNatTo
syn match   nftTerminalStmt     "queue\(\s*num\)\?"

syn keyword nftStatement        log                                 skipwhite nextgroup=nftLog
syn keyword nftStatement        counter                             skipwhite nextgroup=nftCounter
syn keyword nftStatement        limit                               skipwhite nextgroup=nftLimit
syn keyword nftLimit            rate

syn match   nftTerminalStmt     "reject\(\s*with\)\?"               skipwhite nextgroup=nftReject
syn keyword nftReject           contained   tcp icmpx icmp icmpv6   skipwhite nextgroup=nftRejectWith
syn keyword nftRejectWith       contained   type reset

syn keyword nftLog              contained   level prefix group flags level snaplen
syn keyword nftNat              contained   persistent fully-random random
syn keyword nftNatTo            contained   to skipwhite nextgroup=nftNat
syn keyword nftNatProto         contained   ip ip6 skipwhite nextgroup=nftNatTo

syn match   nftCounter          contained   /packets\s*\d\+\s*bytes\s*\d\+/

" Colors
hi def link nftVariable         Identifier
hi def link nftString           String
hi def link nftComment          Comment
hi def link nftContainer        Statement
hi def link nftHeader           Statement
hi def link nftCommand          PreProc
hi def link nftOperator         Operator
hi def link nftInclude          Include
hi def link nftDefine           Define
hi def link nftNumeric          Number
hi def link nftAddress          Constant
hi def link nftSynError         Error

hi def link nftTerminalStmt     Exception
 hi def link nftRejectWith      nftTerminalStmt
 hi def link nftNatTo           nftTerminalStmt
hi def link nftCounter          Comment
hi def link nftReject           Normal

hi def link nftSubStatement     Operator
 hi def link nftLog             nftSubStatement
 hi def link nftNat             nftSubStatement

hi def link nftLabel            Label
 hi def link nftChainType       nftLabel
 hi def link nftChainHook       nftLabel
 hi def link nftChainPolicy     nftLabel
 hi def link nftChainPriority   nftLabel
 hi def link nftTableFamily     nftLabel
 hi def link nftSetType         nftLabel

hi def link nftExtension        Function
hi def link nftFunction         Function
hi def link nftStatement        Function
hi def link nftProtocol         Function
 hi def link nftRaw             nftProtocol

hi def link nftSelector         Operator
 hi def link nftAh              nftSelector
 hi def link nftArp             nftSelector
 hi def link nftComp            nftSelector
 hi def link nftDccp            nftSelector
 hi def link nftEsp             nftSelector
 hi def link nftEther           nftSelector
 hi def link nftIcmp            nftSelector
 hi def link nftIcmpv6          nftSelector
 hi def link nftIgmp            nftSelector
 hi def link nftIp              nftSelector
 hi def link nftIp6             nftSelector
 hi def link nftSctp            nftSelector
 hi def link nftTcp             nftSelector
 hi def link nftUdp             nftSelector
 hi def link nftUdplite         nftSelector
 hi def link nftVlan            nftSelector
 hi def link nftNumgen          nftSelector
 hi def link nftFib             nftSelector
 hi def link nftTcpOption       nftSelector
 hi def link nftIpOption        nftSelector

hi def link nftReference        StorageClass

hi def link nftConntackDir      Special
hi def link nftInterface        Constant

hi def link nftConntack         Operator
hi def link nftMeta             Operator
 hi def link nftMetaQualified   nftMeta
 hi def link nftMetaUnqualified nftMeta

let b:current_syntax = 'nftables'
