" Vim syntax file
" Language: nftables
" Maintainer: Pierre Larsson <pierre.rj.larsson@gmail.com>
" Last Change: 2020 Oct 20

if exists('b:current_syntax')
    finish
endif

syn keyword nftCommand          add create flush delete rename list
syn keyword nftOperator         eq ne lt gt le ge xor or and
syn match   nftInclude          "^\s*\zsinclude"
syn match   nftDefine           "^\s*\zsdefine"
syn match   nftNumeric          "\<\d\+\>"
syn match   nftNumeric          "\<0x[[:xdigit:]]\+\>"
syn match   nftAddress          "[[:xdigit:]:]\+:[[:xdigit:]:/]*"
syn match   nftAddress          "[[:digit:]]\+\.[[:digit:]./]*"
syn match   nftVariable         "\<[@$][a-zA-Z_.][a-zA-Z0-9_/.-]*\>"
syn region  nftString           oneline     start=/"/ end=/"/
syn region  nftComment          oneline     start="^\s*\zs#" end="$"
syn match   nftString           contained   "[a-zA-Z_.][a-zA-Z0-9_/.-]*"
syn match   nftInterface        "\<en[os][[:digit:].]\+\>"
syn match   nftInterface        "\<enp\d\+s[[:digit:].]\+\>"
syn match   nftInterface        "\<eth[[:digit:].]\+\>"
syn match   nftSynError         contained   "\<\w\+\>"

syn keyword nftContainer        table       skipwhite nextgroup=nftTableFamily,nftString
syn keyword nftContainer        chain       skipwhite nextgroup=nftString
syn keyword nftContainer        secmark     skipwhite nextgroup=nftString
syn keyword nftContainer        map         skipwhite nextgroup=nftString
syn keyword nftContainer        set         skipwhite nextgroup=nftString

syn keyword nftHeader           type        skipwhite nextgroup=nftChainType
syn keyword nftHeader           hook        skipwhite nextgroup=nftChainHook
syn keyword nftHeader           priority    skipwhite nextgroup=nftChainPriority
syn keyword nftHeader           policy      skipwhite nextgroup=nftChainPolicy
syn keyword nftHeader           protocol    skipwhite nextgroup=nftProtocols
syn keyword nftHeader           l3proto     skipwhite nextgroup=nftTableFamily
syn keyword nftHeader           device      skipwhite nextgroup=nftInterface

syn keyword nftChainType        contained   filter nat route
syn keyword nftChainHook        contained   input output forward prerouting postrouting ingress
syn keyword nftChainPolicy      contained   accept drop
syn keyword nftChainPriority    contained   raw mangle filter security srcnat dstnat out
syn keyword nftTableFamily      contained   ip ip6 inet arp bridge netdev skipwhite nextgroup=nftString
syn keyword nftReference        vmap
syn keyword nftReference        contained   set

" Protocols
syn keyword nftProtocols        contained   ah arp comp dccp esp ether icmp icmpv6 igmp ip ip6 sctp tcp th udp udplite vlan
syn keyword nftProtos           contained   ipv4 ipv6
syn match   nftRaw              "@\(th\|nh\|ll\)\ze," contains=nftRaw
syn keyword nftRaw              th skipwhite nextgroup=nftAh,nftArp,nftComp,nftDccp,nftEsp,nftEther,nftIcmp,nftIcmpv6,nftIgmp,nftIp,nftIp6,nftSctp,nftTcp,nftUdp,nftUdplite,nftVlan

syn keyword nftProtocol         ah          skipwhite nextgroup=nftAh
syn keyword nftAh               contained   nexthdr hdrlength reserved spi sequence skipwhite nextgroup=nftReference

syn keyword nftProtocol         arp         skipwhite nextgroup=nftArp
syn keyword nftArp              contained   htype ptype hlen plen operation skipwhite nextgroup=nftReference
syn match   nftArp              contained   "\<[sd]addr \(ether\|ip\)\>" skipwhite nextgroup=nftReference

syn keyword nftProtocol         comp        skipwhite nextgroup=nftComp
syn keyword nftComp             contained   nexthdr flags cpi skipwhite nextgroup=nftReference

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

syn keyword nftProtocol         ip          skipwhite nextgroup=nftIp
syn keyword nftIp               contained   version hdrlength dscp ecn length id frag-off ttl protocol checksum saddr daddr skipwhite nextgroup=nftReference

syn keyword nftProtocol         ip6         skipwhite nextgroup=nftIp6
syn keyword nftIp6              contained   version dscp ecn flowlabel length nexthdr hoplimit saddr daddr skipwhite nextgroup=nftReference

syn keyword nftProtocol         sctp        skipwhite nextgroup=nftSctp
syn keyword nftSctp             contained   sport dport vtag checksum skipwhite nextgroup=nftReference

syn keyword nftProtocol         tcp         skipwhite nextgroup=nftTcp
syn keyword nftTcp              contained   sport dport sequence ackseq doff reserved flags window checksum urgptr skipwhite nextgroup=nftReference

syn keyword nftProtocol         udp         skipwhite nextgroup=nftUdp
syn keyword nftUdp              contained   sport dport length checksum skipwhite nextgroup=nftReference

syn keyword nftProtocol         udplite     skipwhite nextgroup=nftUdplite
syn keyword nftUdplite          contained   sport dport checksum skipwhite nextgroup=nftReference

syn keyword nftProtocol         vlan        skipwhite nextgroup=nftVlan
syn keyword nftVlan             contained   id cfi pcp type skipwhite nextgroup=nftReference

" Extensions
syn keyword nftExtension        frag        skipwhite nextgroup=nftFrag
syn keyword nftExtension        dst         skipwhite nextgroup=nftDst
syn keyword nftExtension        hbh         skipwhite nextgroup=nftHbh
syn keyword nftExtension        mh          skipwhite nextgroup=nftMh
syn keyword nftExtension        rt          skipwhite nextgroup=nftRt

" Functions
syn keyword nftFunction         numgen      skipwhite nextgroup=nftNumgen
syn keyword nftNumgen           contained   inc random

syn keyword nftFunction         fib         skipwhite nextgroup=nftFib
syn keyword nftFib              contained   saddr daddr mark iif oif

syn match   nftFunction         /\<ct\>/    skipwhite nextgroup=nftCtDirection,nftCt
syn match   nftContainer        /\<ct\s\+\(helper\|timeout\|expectation\)\>/ skipwhite nextgroup=nftString
syn match   nftFunction         /\<ct\s\+\(helper\|timeout\|expectation\)\s\+set\>/ contains=nftFunction,nftCt,nftReference
syn keyword nftCtDirection      original reply skipwhite nextgroup=nftCt
syn keyword nftCt               state direction status mark expiration helper bytes packets saddr daddr l3proto protocol proto-dst proto-src expectation timeout skipwhite nextgroup=nftReference

syn keyword nftFunction         meta        skipwhite nextgroup=nftMetaQualified,nftMetaUnqualified
syn keyword nftMetaQualified    contained   length priority random secmark ibrpvid ibrvproto skipwhite nextgroup=nftReference
syn keyword nftMetaQualified    contained   nfproto skipwhite nextgroup=nftProto,nftReference
syn keyword nftMetaQualified    contained   l4proto protocol skipwhite nextgroup=nftProtocols,nftReference
syn keyword nftMetaUnqualified  mark iif iifname iiftype oif oifname oiftype skuid skgid nftrace rtclassid ibrname obrname pkttype cpu iifgroup oifgroup cgroup ipsec secpath time day hour iifkind oifkind obriport ibriport skipwhite nextgroup=nftReference

" Statements
syn keyword nftTerminalStatement    accept drop queue continue return
syn keyword nftTerminalStatement    jump goto                           skipwhite nextgroup=nftString
syn keyword nftTerminalStatement    dnat snat masquerade redirect       skipwhite nextgroup=nftNatProto,nftNatTo,nftSynError
syn match   nftTerminalStatement    /queue\(\s*num\)\?/
syn match   nftTerminalStatement    /reject\(\s*with\)\?/               skipwhite nextgroup=nftReject

syn keyword nftStatement            log                                 skipwhite nextgroup=nftLog
syn keyword nftStatement            counter                             skipwhite nextgroup=nftCounter
syn keyword nftStatement            limit                               skipwhite nextgroup=nftLimit
syn keyword nftLimit                rate

syn keyword nftReject               contained   icmp icmpv6 icmpx tcp   skipwhite nextgroup=nftRejectWith
syn keyword nftRejectWith           contained   type reset

syn keyword nftLog                  contained   level prefix group flags level snaplen
syn keyword nftNat                  contained   persistent fully-random random
syn keyword nftNatTo                contained   to skipwhite nextgroup=nftNat
syn keyword nftNatProto             contained   ip ip6 skipwhite nextgroup=nftNatTo

syn match   nftCounter              contained   /packets\s*\d\+\s*bytes\s*\d\+/

" colors
hi def link nftVariable             Identifier
hi def link nftString               String
hi def link nftComment              Comment
hi def link nftContainer            Statement
hi def link nftHeader               Statement
hi def link nftCommand              PreProc
hi def link nftOperator             Operator
hi def link nftInclude              Include
hi def link nftDefine               Define
hi def link nftNumeric              Number
hi def link nftAddress              Constant

hi def link nftTerminalStatement    Exception
hi def link nftCounter              Comment
hi def link nftNatTo                Exception

hi def link nftSubStatement         Normal
 hi def link nftReject              nftSubStatement
 hi def link nftLog                 nftSubStatement
 hi def link nftNat                 nftSubStatement

hi def link nftLabel                Label
 hi def link nftChainType           nftLabel
 hi def link nftChainHook           nftLabel
 hi def link nftChainPolicy         nftLabel
 hi def link nftChainPriority       nftLabel
 hi def link nftSetType             nftLabel
 hi def link nftTableFamily         nftLabel

hi def link nftExtension            Function
hi def link nftFunction             Function
hi def link nftStatement            Function
hi def link nftProtocol             Function
 hi def link nftRaw                 nftProtocol

hi def link nftSelector             Operator
 hi def link nftAh                  nftSelector
 hi def link nftArp                 nftSelector
 hi def link nftComp                nftSelector
 hi def link nftDccp                nftSelector
 hi def link nftEsp                 nftSelector
 hi def link nftEther               nftSelector
 hi def link nftIcmp                nftSelector
 hi def link nftIcmpv6              nftSelector
 hi def link nftIgmp                nftSelector
 hi def link nftIp                  nftSelector
 hi def link nftIp6                 nftSelector
 hi def link nftSctp                nftSelector
 hi def link nftTcp                 nftSelector
 hi def link nftUdp                 nftSelector
 hi def link nftUdplite             nftSelector
 hi def link nftVlan                nftSelector
 hi def link nftNumgen              nftSelector
 hi def link nftFib                 nftSelector

hi def link nftSynError             Error

hi def link nftReference            StorageClass

hi def link nftCtDirection          Special
hi def link nftInterface            Constant

hi def link nftCt                   Operator
hi def link nftMeta                 Operator
 hi def link nftMetaQualified       nftMeta
 hi def link nftMetaUnqualified     nftMeta

let b:current_syntax = 'nftables'
