Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751256AbeDQGhB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 02:37:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:47432 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750821AbeDQGg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 02:36:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,462,1517904000";
   d="gz'50?scan'50,208,50";a="37970012"
Date: Tue, 17 Apr 2018 14:36:25 +0800
From: kbuild test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: kbuild-all@01.org, linux@armlinux.org.uk, maxime.ripard@bootlin.com,
        wens@csie.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        robh+dt@kernel.org, horms@verge.net.au, geert@linux-m68k.org,
        magnus.damm@gmail.com, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, thomas.petazzoni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mylene.josserand@bootlin.com
Subject: Re: [PATCH v6 01/11] ARM: sunxi: smp: Move assembly code into a file
Message-ID: <201804171411.oySI979y%fengguang.wu@intel.com>
References: <20180416215032.5023-2-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180416215032.5023-2-mylene.josserand@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Mylène,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm-soc/for-next]
[also build test ERROR on v4.17-rc1 next-20180416]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Myl-ne-Josserand/Sunxi-Add-SMP-support-on-A83T/20180417-113911
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git for-next
config: arm-sunxi_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   include/asm-generic/bitops/sched.h:14: Error: junk at end of line, first unrecognized character is `{'
   include/asm-generic/bitops/sched.h:20: Error: bad instruction `if (b[0])'
   include/asm-generic/bitops/sched.h:21: Error: bad instruction `return __ffs(b[0])'
   include/asm-generic/bitops/sched.h:22: Error: bad instruction `if (b[1])'
   include/asm-generic/bitops/sched.h:23: Error: bad instruction `return __ffs(b[1])+32'
   include/asm-generic/bitops/sched.h:24: Error: bad instruction `if (b[2])'
   include/asm-generic/bitops/sched.h:25: Error: bad instruction `return __ffs(b[2])+64'
   include/asm-generic/bitops/sched.h:26: Error: bad instruction `return __ffs(b[3])+96'
   include/asm-generic/bitops/sched.h:30: Error: junk at end of line, first unrecognized character is `}'
   include/asm-generic/bitops/arch_hweight.h:7: Error: bad instruction `static inline unsigned int __arch_hweight32(unsigned int w)'
   include/asm-generic/bitops/arch_hweight.h:8: Error: junk at end of line, first unrecognized character is `{'
   include/asm-generic/bitops/arch_hweight.h:9: Error: bad instruction `return __sw_hweight32(w)'
   include/asm-generic/bitops/arch_hweight.h:10: Error: junk at end of line, first unrecognized character is `}'
   include/asm-generic/bitops/arch_hweight.h:12: Error: bad instruction `static inline unsigned int __arch_hweight16(unsigned int w)'
   include/asm-generic/bitops/arch_hweight.h:13: Error: junk at end of line, first unrecognized character is `{'
   include/asm-generic/bitops/arch_hweight.h:14: Error: bad instruction `return __sw_hweight16(w)'
   include/asm-generic/bitops/arch_hweight.h:15: Error: junk at end of line, first unrecognized character is `}'
   include/asm-generic/bitops/arch_hweight.h:17: Error: bad instruction `static inline unsigned int __arch_hweight8(unsigned int w)'
   include/asm-generic/bitops/arch_hweight.h:18: Error: junk at end of line, first unrecognized character is `{'
   include/asm-generic/bitops/arch_hweight.h:19: Error: bad instruction `return __sw_hweight8(w)'
   include/asm-generic/bitops/arch_hweight.h:20: Error: junk at end of line, first unrecognized character is `}'
   include/asm-generic/bitops/arch_hweight.h:22: Error: bad instruction `static inline unsigned long __arch_hweight64(__u64 w)'
   include/asm-generic/bitops/arch_hweight.h:23: Error: junk at end of line, first unrecognized character is `{'
   include/asm-generic/bitops/arch_hweight.h:24: Error: bad instruction `return __sw_hweight64(w)'
   include/asm-generic/bitops/arch_hweight.h:25: Error: junk at end of line, first unrecognized character is `}'
   include/asm-generic/bitops/find.h:30: Error: bad instruction `extern unsigned long find_next_and_bit(const unsigned long*addr1,'
   include/asm-generic/bitops/find.h:31: Error: bad instruction `const unsigned long*addr2,unsigned long size,'
   include/asm-generic/bitops/find.h:32: Error: bad instruction `unsigned long offset)'
   arch/arm/include/asm/swab.h:23: Error: bad instruction `static inline __u32 __arch_swahb32(__u32 x)'
   arch/arm/include/asm/swab.h:24: Error: junk at end of line, first unrecognized character is `{'
   arch/arm/include/asm/swab.h:25: Error: bad instruction `__asm__ ("rev16 %0, %1":"=r"(x):"r"(x))'
   arch/arm/include/asm/swab.h:26: Error: bad instruction `return x'
   arch/arm/include/asm/swab.h:27: Error: junk at end of line, first unrecognized character is `}'
   arch/arm/include/asm/swab.h:31: Error: bad instruction `static inline __u32 __arch_swab32(__u32 x)'
   arch/arm/include/asm/swab.h:32: Error: junk at end of line, first unrecognized character is `{'
   arch/arm/include/asm/swab.h:33: Error: bad instruction `__asm__ ("rev %0, %1":"=r"(x):"r"(x))'
   arch/arm/include/asm/swab.h:34: Error: bad instruction `return x'
   arch/arm/include/asm/swab.h:35: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:47: Error: bad instruction `static inline __u16 __fswab16(__u16 val)'
   include/uapi/linux/swab.h:48: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:50: Error: bad instruction `return ((__u16)__arch_swahb32(val))'
   include/uapi/linux/swab.h:54: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:56: Error: bad instruction `static inline __u32 __fswab32(__u32 val)'
   include/uapi/linux/swab.h:57: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:59: Error: bad instruction `return __arch_swab32(val)'
   include/uapi/linux/swab.h:63: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:65: Error: bad instruction `static inline __u64 __fswab64(__u64 val)'
   include/uapi/linux/swab.h:66: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:70: Error: bad instruction `__u32 h=val>>32'
   include/uapi/linux/swab.h:71: Error: bad instruction `__u32 l=val&((1ULL<<32)-1)'
   include/uapi/linux/swab.h:72: Error: bad instruction `return (((__u64)__fswab32(l))<<32)|((__u64)(__fswab32(h)))'
   include/uapi/linux/swab.h:76: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:78: Error: bad instruction `static inline __u32 __fswahw32(__u32 val)'
   include/uapi/linux/swab.h:79: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:83: Error: bad instruction `return ((__u32)((((__u32)(val)&(__u32)0x0000ffffUL)<<16)|(((__u32)(val)&(__u32)0xffff0000UL)>>16)))'
   include/uapi/linux/swab.h:85: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:87: Error: bad instruction `static inline __u32 __fswahb32(__u32 val)'
   include/uapi/linux/swab.h:88: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:90: Error: bad instruction `return __arch_swahb32(val)'
   include/uapi/linux/swab.h:94: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:161: Error: bad instruction `static inline __u16 __swab16p(const __u16*p)'
   include/uapi/linux/swab.h:162: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:166: Error: bad instruction `return (__builtin_constant_p((__u16)(*p))?((__u16)((((__u16)(*p)&(__u16)0x00ffU)<<8)|(((__u16)(*p)&(__u16)0xff00U)>>8))):__fswab16(*p))'
   include/uapi/linux/swab.h:168: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:174: Error: bad instruction `static inline __u32 __swab32p(const __u32*p)'
   include/uapi/linux/swab.h:175: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:179: Error: bad instruction `return (__builtin_constant_p((__u32)(*p))?((__u32)((((__u32)(*p)&(__u32)0x000000ffUL)<<24)|(((__u32)(*p)&(__u32)0x0000ff00UL)<<8)|(((__u32)(*p)&(__u32)0x00ff0000UL)>>8)|(((__u32)(*p)&(__u32)0xff000000UL)>>24))):__fswab32(*p))'
   include/uapi/linux/swab.h:181: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:187: Error: bad instruction `static inline __u64 __swab64p(const __u64*p)'
   include/uapi/linux/swab.h:188: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:192: Error: bad instruction `return (__builtin_constant_p((__u64)(*p))?((__u64)((((__u64)(*p)&(__u64)0x00000000000000ffULL)<<56)|(((__u64)(*p)&(__u64)0x000000000000ff00ULL)<<40)|(((__u64)(*p)&(__u64)0x0000000000ff0000ULL)<<24)|(((__u64)(*p)&(__u64)0x00000000ff000000ULL)<<8)|(((__u64)(*p)&(__u64)0x000000ff00000000ULL)>>8)|(((__u64)(*p)&(__u64)0x0000ff0000000000ULL)>>24)|(((__u64)(*p)&(__u64)0x00ff000000000000ULL)>>40)|(((__u64)(*p)&(__u64)0xff00000000000000ULL)>>56))):__fswab64(*p))'
   include/uapi/linux/swab.h:194: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:202: Error: bad instruction `static inline __u32 __swahw32p(const __u32*p)'
   include/uapi/linux/swab.h:203: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:207: Error: bad instruction `return (__builtin_constant_p((__u32)(*p))?((__u32)((((__u32)(*p)&(__u32)0x0000ffffUL)<<16)|(((__u32)(*p)&(__u32)0xffff0000UL)>>16))):__fswahw32(*p))'
   include/uapi/linux/swab.h:209: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:217: Error: bad instruction `static inline __u32 __swahb32p(const __u32*p)'
   include/uapi/linux/swab.h:218: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:222: Error: bad instruction `return (__builtin_constant_p((__u32)(*p))?((__u32)((((__u32)(*p)&(__u32)0x00ff00ffUL)<<8)|(((__u32)(*p)&(__u32)0xff00ff00UL)>>8))):__fswahb32(*p))'
   include/uapi/linux/swab.h:224: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:230: Error: bad instruction `static inline void __swab16s(__u16*p)'
   include/uapi/linux/swab.h:231: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:235: Error: junk at end of line, first unrecognized character is `*'
   include/uapi/linux/swab.h:237: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:242: Error: bad instruction `static inline void __swab32s(__u32*p)'
   include/uapi/linux/swab.h:243: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:247: Error: junk at end of line, first unrecognized character is `*'
   include/uapi/linux/swab.h:249: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:255: Error: bad instruction `static inline void __swab64s(__u64*p)'
   include/uapi/linux/swab.h:256: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:260: Error: junk at end of line, first unrecognized character is `*'
   include/uapi/linux/swab.h:262: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:270: Error: bad instruction `static inline void __swahw32s(__u32*p)'
   include/uapi/linux/swab.h:271: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:275: Error: junk at end of line, first unrecognized character is `*'
   include/uapi/linux/swab.h:277: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:285: Error: bad instruction `static inline void __swahb32s(__u32*p)'
   include/uapi/linux/swab.h:286: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:290: Error: junk at end of line, first unrecognized character is `*'
   include/uapi/linux/swab.h:292: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/byteorder/little_endian.h:44: Error: bad instruction `static inline __le64 __cpu_to_le64p(const __u64*p)'
>> include/uapi/linux/byteorder/little_endian.h:45: Error: junk at end of line, first unrecognized character is `{'
>> include/uapi/linux/byteorder/little_endian.h:46: Error: bad instruction `return (__force __le64)*p'
   include/uapi/linux/byteorder/little_endian.h:47: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/byteorder/little_endian.h:48: Error: bad instruction `static inline __u64 __le64_to_cpup(const __le64*p)'
   include/uapi/linux/byteorder/little_endian.h:49: Error: junk at end of line, first unrecognized character is `{'
>> include/uapi/linux/byteorder/little_endian.h:50: Error: bad instruction `return (__force __u64)*p'
   include/uapi/linux/byteorder/little_endian.h:51: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/byteorder/little_endian.h:52: Error: bad instruction `static inline __le32 __cpu_to_le32p(const __u32*p)'
   include/uapi/linux/byteorder/little_endian.h:53: Error: junk at end of line, first unrecognized character is `{'
>> include/uapi/linux/byteorder/little_endian.h:54: Error: bad instruction `return (__force __le32)*p'
   include/uapi/linux/byteorder/little_endian.h:55: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/byteorder/little_endian.h:56: Error: bad instruction `static inline __u32 __le32_to_cpup(const __le32*p)'
   include/uapi/linux/byteorder/little_endian.h:57: Error: junk at end of line, first unrecognized character is `{'
>> include/uapi/linux/byteorder/little_endian.h:58: Error: bad instruction `return (__force __u32)*p'
   include/uapi/linux/byteorder/little_endian.h:59: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/byteorder/little_endian.h:60: Error: bad instruction `static inline __le16 __cpu_to_le16p(const __u16*p)'
   include/uapi/linux/byteorder/little_endian.h:61: Error: junk at end of line, first unrecognized character is `{'
>> include/uapi/linux/byteorder/little_endian.h:62: Error: bad instruction `return (__force __le16)*p'
   include/uapi/linux/byteorder/little_endian.h:63: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/byteorder/little_endian.h:64: Error: bad instruction `static inline __u16 __le16_to_cpup(const __le16*p)'
   include/uapi/linux/byteorder/little_endian.h:65: Error: junk at end of line, first unrecognized character is `{'
>> include/uapi/linux/byteorder/little_endian.h:66: Error: bad instruction `return (__force __u16)*p'
   include/uapi/linux/byteorder/little_endian.h:67: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/byteorder/little_endian.h:68: Error: bad instruction `static inline __be64 __cpu_to_be64p(const __u64*p)'
   include/uapi/linux/byteorder/little_endian.h:69: Error: junk at end of line, first unrecognized character is `{'
>> include/uapi/linux/byteorder/little_endian.h:70: Error: bad instruction `return (__force __be64)__swab64p(p)'
   include/uapi/linux/byteorder/little_endian.h:71: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/byteorder/little_endian.h:72: Error: bad instruction `static inline __u64 __be64_to_cpup(const __be64*p)'
   include/uapi/linux/byteorder/little_endian.h:73: Error: junk at end of line, first unrecognized character is `{'
>> include/uapi/linux/byteorder/little_endian.h:74: Error: bad instruction `return __swab64p((__u64*)p)'
   include/uapi/linux/byteorder/little_endian.h:75: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/byteorder/little_endian.h:76: Error: bad instruction `static inline __be32 __cpu_to_be32p(const __u32*p)'
   include/uapi/linux/byteorder/little_endian.h:77: Error: junk at end of line, first unrecognized character is `{'
>> include/uapi/linux/byteorder/little_endian.h:78: Error: bad instruction `return (__force __be32)__swab32p(p)'
   include/uapi/linux/byteorder/little_endian.h:79: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/byteorder/little_endian.h:80: Error: bad instruction `static inline __u32 __be32_to_cpup(const __be32*p)'
   include/uapi/linux/byteorder/little_endian.h:81: Error: junk at end of line, first unrecognized character is `{'

vim +44 include/uapi/linux/byteorder/little_endian.h

5921e6f8 David Howells  2012-10-13   43  
bc27fb68 Denys Vlasenko 2016-03-17  @44  static __always_inline __le64 __cpu_to_le64p(const __u64 *p)
5921e6f8 David Howells  2012-10-13  @45  {
5921e6f8 David Howells  2012-10-13  @46  	return (__force __le64)*p;
5921e6f8 David Howells  2012-10-13  @47  }
bc27fb68 Denys Vlasenko 2016-03-17  @48  static __always_inline __u64 __le64_to_cpup(const __le64 *p)
5921e6f8 David Howells  2012-10-13  @49  {
5921e6f8 David Howells  2012-10-13  @50  	return (__force __u64)*p;
5921e6f8 David Howells  2012-10-13  @51  }
bc27fb68 Denys Vlasenko 2016-03-17  @52  static __always_inline __le32 __cpu_to_le32p(const __u32 *p)
5921e6f8 David Howells  2012-10-13  @53  {
5921e6f8 David Howells  2012-10-13  @54  	return (__force __le32)*p;
5921e6f8 David Howells  2012-10-13  @55  }
bc27fb68 Denys Vlasenko 2016-03-17  @56  static __always_inline __u32 __le32_to_cpup(const __le32 *p)
5921e6f8 David Howells  2012-10-13  @57  {
5921e6f8 David Howells  2012-10-13  @58  	return (__force __u32)*p;
5921e6f8 David Howells  2012-10-13  @59  }
bc27fb68 Denys Vlasenko 2016-03-17  @60  static __always_inline __le16 __cpu_to_le16p(const __u16 *p)
5921e6f8 David Howells  2012-10-13  @61  {
5921e6f8 David Howells  2012-10-13  @62  	return (__force __le16)*p;
5921e6f8 David Howells  2012-10-13  @63  }
bc27fb68 Denys Vlasenko 2016-03-17  @64  static __always_inline __u16 __le16_to_cpup(const __le16 *p)
5921e6f8 David Howells  2012-10-13  @65  {
5921e6f8 David Howells  2012-10-13  @66  	return (__force __u16)*p;
5921e6f8 David Howells  2012-10-13  @67  }
bc27fb68 Denys Vlasenko 2016-03-17  @68  static __always_inline __be64 __cpu_to_be64p(const __u64 *p)
5921e6f8 David Howells  2012-10-13  @69  {
5921e6f8 David Howells  2012-10-13  @70  	return (__force __be64)__swab64p(p);
5921e6f8 David Howells  2012-10-13  @71  }
bc27fb68 Denys Vlasenko 2016-03-17  @72  static __always_inline __u64 __be64_to_cpup(const __be64 *p)
5921e6f8 David Howells  2012-10-13  @73  {
5921e6f8 David Howells  2012-10-13  @74  	return __swab64p((__u64 *)p);
5921e6f8 David Howells  2012-10-13  @75  }
bc27fb68 Denys Vlasenko 2016-03-17  @76  static __always_inline __be32 __cpu_to_be32p(const __u32 *p)
5921e6f8 David Howells  2012-10-13  @77  {
5921e6f8 David Howells  2012-10-13  @78  	return (__force __be32)__swab32p(p);
5921e6f8 David Howells  2012-10-13  @79  }
bc27fb68 Denys Vlasenko 2016-03-17  @80  static __always_inline __u32 __be32_to_cpup(const __be32 *p)
5921e6f8 David Howells  2012-10-13  @81  {
5921e6f8 David Howells  2012-10-13  @82  	return __swab32p((__u32 *)p);
5921e6f8 David Howells  2012-10-13   83  }
bc27fb68 Denys Vlasenko 2016-03-17  @84  static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
5921e6f8 David Howells  2012-10-13   85  {
5921e6f8 David Howells  2012-10-13  @86  	return (__force __be16)__swab16p(p);
5921e6f8 David Howells  2012-10-13   87  }
bc27fb68 Denys Vlasenko 2016-03-17  @88  static __always_inline __u16 __be16_to_cpup(const __be16 *p)
5921e6f8 David Howells  2012-10-13   89  {
5921e6f8 David Howells  2012-10-13  @90  	return __swab16p((__u16 *)p);
5921e6f8 David Howells  2012-10-13   91  }
5921e6f8 David Howells  2012-10-13   92  #define __cpu_to_le64s(x) do { (void)(x); } while (0)
5921e6f8 David Howells  2012-10-13   93  #define __le64_to_cpus(x) do { (void)(x); } while (0)
5921e6f8 David Howells  2012-10-13   94  #define __cpu_to_le32s(x) do { (void)(x); } while (0)
5921e6f8 David Howells  2012-10-13   95  #define __le32_to_cpus(x) do { (void)(x); } while (0)
5921e6f8 David Howells  2012-10-13   96  #define __cpu_to_le16s(x) do { (void)(x); } while (0)
5921e6f8 David Howells  2012-10-13   97  #define __le16_to_cpus(x) do { (void)(x); } while (0)
5921e6f8 David Howells  2012-10-13   98  #define __cpu_to_be64s(x) __swab64s((x))
5921e6f8 David Howells  2012-10-13   99  #define __be64_to_cpus(x) __swab64s((x))
5921e6f8 David Howells  2012-10-13  100  #define __cpu_to_be32s(x) __swab32s((x))
5921e6f8 David Howells  2012-10-13  101  #define __be32_to_cpus(x) __swab32s((x))
5921e6f8 David Howells  2012-10-13  102  #define __cpu_to_be16s(x) __swab16s((x))
5921e6f8 David Howells  2012-10-13  103  #define __be16_to_cpus(x) __swab16s((x))
5921e6f8 David Howells  2012-10-13  104  
5921e6f8 David Howells  2012-10-13  105  

:::::: The code at line 44 was first introduced by commit
:::::: bc27fb68aaad44dd8f5c34924f05721f0abaeec1 include/uapi/linux/byteorder, swab: force inlining of some byteswap operations

:::::: TO: Denys Vlasenko <dvlasenk@redhat.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--IJpNTDwzlM2Ie8A6
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--IJpNTDwzlM2Ie8A6--
