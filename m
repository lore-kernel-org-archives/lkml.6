Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbeCZKDJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 06:03:09 -0400
Received: from mail-sn1nam02on0040.outbound.protection.outlook.com ([104.47.36.40]:16832
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751024AbeCZKDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 06:03:07 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jan.Glauber@cavium.com;
Date: Mon, 26 Mar 2018 12:02:50 +0200
From: Jan Glauber <jan.glauber@caviumnetworks.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: defconfig: Raise NR_CPUS to 256
Message-ID: <20180326100250.GC5991@hc>
References: <20180302143737.10788-1-jglauber@cavium.com>
 <20180302143737.10788-2-jglauber@cavium.com>
 <CAK8P3a2ORBU-_7=JeCHSuM8YtC7zeO1VPxQzny_8BrpyVGCKKw@mail.gmail.com>
 <20180306140201.GB7428@hc>
 <20180326085214.GB5991@hc>
 <CAK8P3a03GvQKC58GXLWJaKwSWRq5LY7Jx3ftfFfpVbq1jAz3Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a03GvQKC58GXLWJaKwSWRq5LY7Jx3ftfFfpVbq1jAz3Pg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [109.193.46.73]
X-ClientProxiedBy: HE1PR0902CA0043.eurprd09.prod.outlook.com
 (2603:10a6:7:15::32) To CY1PR07MB2508.namprd07.prod.outlook.com
 (2a01:111:e400:c636::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f03209f0-5d7e-4275-3f4d-08d59300c46c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR07MB2508;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2508;3:bwJn/5r7l5mXhSsTTYrJjVVVWiAOfGiwIU+4HHN01xmHuoxqTF3VIDwy5JRYN1uNVtdGXaPpeFcFMWQiW/6gbCZX3rvHA5Q3DyhbYTpU5/hXuuRESOjOYqXQJDY58OtyR5RVZSciZRMQLGz1P76KZn+ST+qaX3UUalDc38SNeI139vd8Oa8nE49dyIAQIakdhNV1wYTUoW2xRsNu5T5uCjlx50WlAdDBzJMomhl3Lqfqfo7SN74+klDeBWZCfwyn;25:OmdK44SDW4/M94Dm65n/l0Nem3hmycGUV1mjlBpd06nNaIG7C6W1joiYJUrXq4gK1PpGkUUHzD7+agxaivTJ6WXWjD6wniCmpeoM4IovjFoRwFQX9QAJXycNrY8pZQnP0L87B8s+H0L9IcCENa9pYiX83sZDajPnAcA466MBBqHsIMEHjhdlt/h7jkFz8z539iU9OUKiwssj0ljxAtaxy8PMtiyoxxkoB+x1JHGCSB9UyUR9OOe5WKrB6XEpPhSsLKhq0GIQs14KqNbz5UnzoOY0b0NEDT0Dxpx4xOKtv1iULERNNVc+tAZ0tMa1Rr0KQdYRfeWFlKEw9I6786h9Rw==;31:Pam+7AisxA3GtAoM490LKxkAzZkAOf0NxaQMuKWihDsITJXgaE/F2xAI8q9TjYxsdn7SJwhb+0UyRB9PILPQIFC1cDZ6+dqZhQmbOUu1pjpzPb71pLnfY0QR6S7faefeK7/dtL37Av1R4gWIoHC1oEmBVj7Y7P/8Paka3+FzZ4B6cuoCww5Axu4JWZJmBKCujoaPxbMrZvuGA+ozfabCRpzZUGwA0TFD6R2YfN8he2A=
X-MS-TrafficTypeDiagnostic: CY1PR07MB2508:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2508;20:M0wT9tuvrjEqBrCmDx+U8cPOHM9ZmqdZRquiB7AmboV+MDbbeOlhAAJzcZ8wL9jppFaapHAl+Xt4zl4d+GvvjWhCS3SQW0O/GXfYMo3j6h9mPq3LKXK3T1MkCr8c3TCK6vWX3uoeTrzIJtEVEarB/erZBJf+Q2YH/AzEjsm9lNazi91es3/YMsEZ9WSdEOFFm33f6WUIKlEsW/wSgC9La0Xg38k3f8wEhl941wsDW1zOpytvxZRDvIHqvMYgnHMlEsTC2jLKW+M9uy4gHPv5jRSHd2mlhPv2EBwv5938zdKjXK2F6OUbhpBcTDbHij/myugwKUMltzPkZO7SJm1ygfYqJQZMZdU8Z1tIRZq5UDLzNOnvhBX/ptbxcK9kZ93qbrq4hfhmeVHO3Z5rwdjKx0X0myMolVO5yq2Hm+Cf1FBiYeBGyu6nfxgLYOdy72LJcPQU+/PSkPkZ1AQm4U/HXJL8989qp54u4m9iuLzVzSNRlhsWM0byEW6gVE1ebUI6M3885LHOl9fB8xQ18U4kBHW1+Qa57isJ/eYRuQE8WmpVDbrMvLjR0ycJrEoiLypkkJf042seCnRszDRlTZDeDP3Xb57RqdOdrgbQzFMSx6Y=
X-Microsoft-Antispam-PRVS: <CY1PR07MB2508E4EE28C256BF1F91265F91AD0@CY1PR07MB2508.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863)(155532106045638);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:CY1PR07MB2508;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2508;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2508;4:7aorAMAZi9jcBD2dgQBBbvVOFiB5qJvtH0nMZ2k6CTeaipCS8lx93bAn4NE22+XF6kUh8n0Krw3DKeZD9MOJd+E01V1lSNmVNVftwvgxrUJYeVJIRvzvVaiW/S6P3ykWS90q+lcz6aICB0yJcfWyIUPrZ+mJ47kLCgeeOlhJLGGgsNFieG00b3rPhE1LSJ/wmuo8A0S9nYFUMZQIdkke2Fh6mXaZXxAO9MKbzP41oSc3CEHgD61u7NT/VKUB/m+jTTrYPnFwXA+Up3IGAqwITcpUj1AX8Zkrv8FycQ1N0rCkgXGSbfjPIDCFjVi6jzVgpmMJkZ2wxqkdO5tPw/BQ4d14Qp6MaVr2j4Y29/l9MnY=
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(39380400002)(39850400004)(376002)(189003)(199004)(93886005)(66066001)(6916009)(11346002)(6666003)(33896004)(33716001)(8676002)(50466002)(446003)(97736004)(53546011)(386003)(59450400001)(47776003)(8936002)(316002)(42882007)(58126008)(16586007)(81156014)(81166006)(956004)(76176011)(7736002)(305945005)(16526019)(229853002)(5660300001)(186003)(68736007)(54906003)(25786009)(55016002)(9686003)(23726003)(1076002)(33656002)(6246003)(6116002)(53936002)(3846002)(52116002)(26005)(72206003)(6496006)(478600001)(105586002)(4326008)(2906002)(106356001)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2508;H:hc;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR07MB2508;23:QzVvVZPs/D3TOv1Xz7X1ZomOLD534oze1jC1Y0Utt?=
 =?us-ascii?Q?MrOTQxpS9TQVbP/GNHKTuVKbzw1gfP2BeHfBLLTqNhP2Tb+cwF0QIyPopYbC?=
 =?us-ascii?Q?LbCC0+p7TkHZLTobgZJA23La98NfTGtO55fIUayL3mTx0jrETDRY8ZyOHDtT?=
 =?us-ascii?Q?dOfHLrPZ3YqU6cZLHpCy47HO9skfKpJcdPS3sIvcqlv25OeN4uZrbwsHgBHk?=
 =?us-ascii?Q?RQmZI9LXBuNkeYEj280WBAZabJAbM19c6hA72RvmrUQO9OSG06Dh9RgXHvQq?=
 =?us-ascii?Q?irwq1BQnxZWZ4wE/hqVjEC4gwaltEkXJz2HTQ2+JbAS1cpRvLphqtGU2YVre?=
 =?us-ascii?Q?Ao0STv4rMd3tnQpBtN9y2d2KMs4bsv9OvDMkDYfZlDrr34ABsxjMZDMlKiC6?=
 =?us-ascii?Q?BsThYMUT1I5xj4yCqlnq+2CopHV7lKWy4ctwXBdmwd+IVvxz1H9QWPyX5Epc?=
 =?us-ascii?Q?NE0997AVsQp3ikKImgpsnIomnyn0NSrQjyiUPHD2hgz3Mv2VXTX77tx/c+fq?=
 =?us-ascii?Q?AbX5ceLCHYdWgaSky0/Aw9LOcWkuC2V72sgXc3ZbE0ZB2w1jsK+77KMBU2gD?=
 =?us-ascii?Q?bmR13F/cVFZ6owuxxXkvPIJP+QeHTCw06nJ7OIz2roqMS0L4hJ/DyTPcNuCn?=
 =?us-ascii?Q?mQNyQjDjblkm6vWnpyyh5bWewh71JOQrw01e6tT5IABsQtt80IoCaSYtvVAk?=
 =?us-ascii?Q?Dlr5qjErkGv1nlRAAMZg4v7RB6SiRyJbno1jrAmabXHtJ5aUtFx7VuRCDfTi?=
 =?us-ascii?Q?raphcSKC3qmd+Wiz7CJAxEJg8JWHOCFG92zuGgdA4EWfb8B7qv1EEQZnV94o?=
 =?us-ascii?Q?6GVQ43y8+Wxb4GbojdJgZ+OmXWBvglPMKfD80khEOedordoBMx0Ma7zQO3c9?=
 =?us-ascii?Q?Ak8y9ot2yYdJTzc9K2peMIZAdxp7jX6u+IPGM6tLx2bxY51Rn4LNtx5+9FXL?=
 =?us-ascii?Q?DPgXDu1GIXDSeMx+kGhTxSlXnJGZjQsK2n2rYzzYIINppG4UExoZUv7+vumo?=
 =?us-ascii?Q?sxOi1Fpo/MKd8+b4xOkyXByCvp0H6pasrhdSdApQ8xbJKDnkH4bQXzwQ6Hy0?=
 =?us-ascii?Q?7/wSmfJBkYrEtijSiMvhUMzChQlCvpVaZ42PSPtsjshavrvJh3XpZuQbUCyw?=
 =?us-ascii?Q?S7Lohk6HtHlneVODVtGEvbaZt32iveaaamAa81HAHm9JuR2ClYIcYS8oFfN6?=
 =?us-ascii?Q?SpzYT2iFONnC4zDgXiAcSi12WEGoe5/z4KGa8EZJ/wjVZcx1ASzJ+J7o0Bzy?=
 =?us-ascii?Q?fAsjXPVVPE5Yd6RW7GujWLVbRDoXNF5OYWdKfkDo4+JQ4XnYx67xr3u3pIl1?=
 =?us-ascii?Q?h3ca2gAIsghuPKijB2Od44z16BqZ+SatacsGWzswN97+HAk/BXafcPEmHIl5?=
 =?us-ascii?Q?oMvEA=3D=3D?=
X-Microsoft-Antispam-Message-Info: L0hGfB5ntm76D+z2zFQ+6Xufav8Va2Yys2ScYNgnulWcyvGI+CeusekpMSMw/JLbvvK92lNdSAfDKDNjZEi4bLEOks+kwwc5qeT/DnfYYqpj7f7DrfnMCmP4Fja5OmRz2dw3a9cxFhRhACGDykaeM2vwtaBSLNo+2LYkYLN4s6AmxwXvQ5H8aK8VCWxtpebT
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2508;6:6LVoPAhJxDUZoi6gTYBl2u3MiwNxEPazhpMjGWgSaYX/gZVutKB5smkOp4TMaS+HajdHjdbyqRH5LWZL0RtaSke7LpYYsgx23aEbhoNrsyMOYZ6aGnPumArXMtAfZ+xwP45Wz47XH3NZpuCI5UBGRrmsPFokbwxO99DQjiNqT7T3UlTSsny2oMLiwZ3QxnIfzy9Lv2c0S9QFME3DYpCNnovFs+SSrME8i8FbbAOaPqiVLJrMMSojIdw+WEhSbDeE17ysM0/LtI2rY9HvHc/L3m+ct4VHmulOAjrpmsrGuWjF23szgLgfCrnlZ7X1pRkpMScLiZciUaC5cVeMmIFQu/PFUOhc2TCEbMOT+0gJymraEuDFkh+QPMzXmy3k4PByuWH2dyNmjwM69bpfwC6WkL7vDRCuBliDXh63Hxey5DEYNxdTcAS+tr+GtjVnraIWaxCjinmr6IQuzcLDQiBv5w==;5:HpLd4rzT285cbuLOZFi55wbKIiOBubJSQ5kjFPnxfaq8HZHwOV94fYjfkrl/JQfuQh3GDgruIC9dACcyxpGzn6/1A4saX+Xj/Z603u/fu4+KahZdJpUK3hVJaoTZkry26ZksKfeTcbaYBC3K3l4Qu1+mpCUEvGN4+OyU+Pc8E0w=;24:I3BQemwYS8678jMNaDz1KHYYlyTWYE1D+SyxJg6vAXL++BuEOf6Wv/UJ6eRaxiwE2kialFe+TBgv/rfD1Mi/p5TxCF9Hv/2Z1Odu0vNb1x4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2508;7:pCGy/orBNVDEn986hqcDvO7o3tcWzb5YrN/hYCLTFYkDb0+qJUYmy93NQWiuH8e/XcAdPXB3XqFjjfoKcIfq2rUh8QGCj8edN/cTH8z42rVVn792TcSiw9tg1oVqHsofhEYmjFj2KIz8ZWSlo0Daqq+ShKjeZPTDwtJTBf+RCj+ZOgLeHpARUMNu27Eu1hJLTb3a/9z20UvUE5NAYh1PeQtlLdWxgQqIW0mW5yRCfbNs2YJ2nprFpI0M9/Gh/lXY
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 10:03:03.1879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f03209f0-5d7e-4275-3f4d-08d59300c46c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2508
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 11:28:28AM +0200, Arnd Bergmann wrote:
> On Mon, Mar 26, 2018 at 10:52 AM, Jan Glauber
> <jan.glauber@caviumnetworks.com> wrote:
> > On Tue, Mar 06, 2018 at 03:02:01PM +0100, Jan Glauber wrote:
> >> On Tue, Mar 06, 2018 at 02:12:29PM +0100, Arnd Bergmann wrote:
> >> > On Fri, Mar 2, 2018 at 3:37 PM, Jan Glauber <jglauber@cavium.com> wrote:
> >> > > ThunderX1 dual socket has 96 CPUs and ThunderX2 has 224 CPUs.
> >> >
> >> > Are you sure about those numbers? From my counting, I would have expected
> >> > twice that number in both cases: 48 cores, 2 chips and 2x SMT for ThunderX
> >> > vs 52 Cores, 2 chips and 4x SMT for ThunderX2.
> >>
> >> That's what I have on those machines. I counted SMT as normal CPUs as it
> >> doesn't make a difference for the config. I've not seen SMT on ThunderX.
> >>
> >> The ThunderX2 number of 224 is already with 4x SMT (and 2 chips) but
> >> there may be other versions planned that I'm not aware of.
> >>
> >> > > Therefore raise the default number of CPUs from 64 to 256
> >> > > by adding an arm64 specific option to override the generic default.
> >> >
> >> > Regardless of what the correct numbers for your chips are, I'd like
> >> > to hear some other opinions on how high we should raise that default
> >> > limit, both in arch/arm64/Kconfig and in the defconfig file.
> >> >
> >> > As I remember it, there is a noticeable cost for taking the limit beyond
> >> > BITS_PER_LONG, both in terms of memory consumption and also
> >> > runtime performance (copying and comparing CPU masks).
> >>
> >> OK, that explains the default. My unverified assumption is that
> >> increasing the CPU masks wont be a noticable performance hit.
> >>
> >> Also, I don't think that anyone who wants performance will use
> >> defconfig. All server distributions would bump up the NR_CPUS anyway
> >> and really small systems will probably need to tune the config
> >> anyway.
> >>
> >> For me defconfig should produce a usable system, not with every last
> >> driver configured but with all the basics like CPUs, networking, etc.
> >> fully present.
> >>
> >> > I'm sure someone will keep coming up with even larger configurations
> >> > in the future, so we should try to decide how far we can take the
> >> > defaults for the moment without impacting users of the smallest
> >> > systems. Alternatively, you could add some measurements that
> >> > show how much memory and CPU time is used up on a typical
> >> > configuration for a small system (4 cores, no SMT, 512 MB RAM).
> >> > If that's low enough, we could just do it anyway.
> >>
> >> OK, I'll take a look.
> >
> > I've made some measurements on a 4 core board (Cavium 81xx) with
> > NR_CPUS set to 64 or 256:
> >
> > - vmlinux grows by 0.04 % with 256 CPUs
> 
> Ok. Is this both with CONFIG_CPUMASK_OFFSTACK=n?

Yes.

> > - Kernel compile time was a bit faster with 256 CPUS (which does
> >   not make sense, but at least is seems to not suffer from the change).
> 
> Do you mean compiling the same kernel configuration while running
> on a system with less than 64 CPUs on either a CONFIG_NR_CPUS=64
> or CONFIG_NR_PCUS=256 kernel, or do you mean the time to compile
> a kernel with either CONFIG_NR_CPUS=64 or CONFIG_NR_CPUS=256,
> while running on the same host?

The former, compiling everything on a 4-core system using two different
kernels to compile the same thing.

> I assume the former, which is a very interesting result, possibly
> pointing to us doing something wrong in the NR_CPUS=64 case
> that could be optimized.
> 
> If you ran with CONFIG_CPUMASK_OFFSTACK, that may have made
> a significant difference, but I would expect it to be faster without it.
> 
> To get more insight to what is happening, you could rerun the same
> test with 'perf record' and then compare the profiles. How significant
> is the runtime difference compared to the jitter you get between normal
> runs on the same configuration?

I did retry once but the odd case that CONFIG_NR_CPUS=256 was faster
was consistent. The difference was very small though so it may be
completely due to jitter.

> >   Is there a benchmark that will be better suited? Maybe even a
> >   microbenchmark that will suffer from the longer cpumasks?
> 
> Good question.
> 
> > - Available memory decreased by 0.13% (restricted memory to 512 MB),
> >   BSS increased 5.3 %
> 
> 0.13% of a few hundred megabytes is still several hundred kb, right? I'd
> like to hear some other opinions on that, but it seems to be in the
> range of enabling many additional device drivers, which is something
> we don't do lightly.

Agreed, available memory was reduced by 128 KB.

--Jan
