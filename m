Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751204AbeCZIw2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:52:28 -0400
Received: from mail-cys01nam02on0071.outbound.protection.outlook.com ([104.47.37.71]:46596
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751024AbeCZIw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:52:26 -0400
Date: Mon, 26 Mar 2018 10:52:14 +0200
From: Jan Glauber <jan.glauber@caviumnetworks.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: defconfig: Raise NR_CPUS to 256
Message-ID: <20180326085214.GB5991@hc>
References: <20180302143737.10788-1-jglauber@cavium.com>
 <20180302143737.10788-2-jglauber@cavium.com>
 <CAK8P3a2ORBU-_7=JeCHSuM8YtC7zeO1VPxQzny_8BrpyVGCKKw@mail.gmail.com>
 <20180306140201.GB7428@hc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306140201.GB7428@hc>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [109.193.46.73]
X-ClientProxiedBy: CWLP265CA0232.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4f::28) To BN3PR07MB2500.namprd07.prod.outlook.com
 (2a01:111:e400:7bbf::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a103a99-abc9-42c6-2072-08d592f6e4f1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN3PR07MB2500;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2500;3:7aan3uw3omgg+Lqm9foS4+AWFjp0IN72hnCR0i4ugDK48Y6+XIDbQy7bxU+IWDu3Q+tg4Xo0BTNxiHM0QK3JOD+JL/uOk24mNwS9wyWXdR4yrypse5uCd9vLpnEwLxwDEYZGd+MxS5f2ZlEdaDvBT+i7pGZdTqkuo5671y9ZylE2eMf9GW+2cwD0kU7b0sxWrXIU9eX+ValK58/hBy5uCKeMXNOb/DRQYEfQAqiq2ZN/P12lWY+LJKeASrWKwza8;25:tMlUSoZ6cbsPprHoT+Edhkkz7dc27S0JlRB121rDwxZgFs6DCEAlJA6Nt0CFwkjzLG00bq8IxpgAcz8Tk3Qx74YCIrJCcgHEe/KcDFTVjCwY6UOU+h3Zdjm4RDYxBu5gCQgdibGvhFg1WSCRqBke5xfugDqk+u3WS17A+cqo3pQMeHcab4hLWxw/zt3WZPbEW9KUTOH5dvfzRJNw02HmsgEBcYfAWrRIhZOEVdLnxQv1t960kpXUWTFko8q6FKyav99/refJhvMvy02l2mZwuY+T476cZRa6/fpuedHCCNIvPqbSeo39ywLClb7rzpBidy3vlX5cgZsR+/YPTINRsg==;31:wQTsaik4TLTrFR5KvPiw8M6lkERACLtAyj5UgUX3OiWZzybajaVNXsPMVzY1sbPaPXrQ2+1jPxiawizv5zb1yCWcF6bzJcn+b80kGa8W9QOOtZFNZ+cmbfp0AFyl5+CKiZn/M4FAzsk37oOaO+wXNEtrnkrkPtKNYrnYpYIHP2NOFSjWo/3Q0CELcTR4nGx+hoSkpZLiorTw9tUosoWZcfCbOlLKegJYViN/7sLd+0M=
X-MS-TrafficTypeDiagnostic: BN3PR07MB2500:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jan.Glauber@cavium.com;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2500;20:oRUqbpnhtnbdaMVtrJc99NT8G6o3REya4la6gt0fNle2ljmv2bcqzo0NFrMRMmhOB+PMBwFQtSvOEO68n/tjVzVi5czU4LvuKFHe3GEL9SkYdSH/ijggiAfEgEd8uolrFhneFPzw+dRpVLY+06rfeQLRCq0dZ1XZjQjrMcLd2O84NIJGQfJBbGz2WtofqlcO19RJ09oDgmG04DCEWBQGQDMcnPkuV0neyEIU5AuNaG3S0XK865OZ8OQYi3sfii/W5wVEitvN3aiMjo8yXg+LJOb34UNuVJR7Y5c/jSZruN1ymJfQQUvzP0Wj4y2vQDIT/ly6Pd2omp1QpaMj+qqv9y0XtCfJDuW+jiH/EJDOHtv2wxaaLT0ylpiHRwo5MY/HeDB3z7qZhLkb8Uqu0mRQfPCI8pvlLSFUTgkbC12vhczr1dru7IzE/SjhJPxKEFLzh9L8OemMV5b7p9lmgQc9UqhWaL3Dwk+sLelmuEE1SsbrVJG8QttyORd7dNSkYkfaoacxl3KuGc6BpQdvTZcB/cpyyYI9ycnxne2nNFfnxoZNoAb0EpYvZXVE3zTB1oLflh4ma5L4tptP+QtnxOQUpogtuhRusYScVMY3YxF+iVY=;4:whl27eaZp4pz3GiWmRg6i1A1BwOCOfB0cACuZKA/p/4Ed5/5nIwRUxnaPyUz330gopGiWRnrDY3sThr+h/zHLdD4Sh1U2GslIMglWZH99Z9grJk5rg5vE7A8l7+XgyQz81P+KFrbH6Cnh/Uc8OYlVPQu0XVldkAqkXP0XVO83Cos2iQ1xb2sqRONci/MS59GaFgm4K8ciES5wv9JI8L/LsEdH5bH4hkaDTpdrMWXA9s01kh50RW3Vr7Nzik3fDkNy6y72sNJUje26vPa5eUP1YrvS79SajxJFIOQku/LV0JrREPZuKxoc1kfAF82cbW8
X-Microsoft-Antispam-PRVS: <BN3PR07MB25000BB27CCA00346230E80091AD0@BN3PR07MB2500.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:BN3PR07MB2500;BCL:0;PCL:0;RULEID:;SRVR:BN3PR07MB2500;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(39380400002)(376002)(39850400004)(189003)(199004)(7736002)(6496006)(72206003)(33896004)(76176011)(305945005)(47776003)(68736007)(50466002)(66066001)(52116002)(25786009)(956004)(4326008)(33716001)(97736004)(8936002)(2906002)(54906003)(58126008)(478600001)(53546011)(11346002)(6916009)(33656002)(16586007)(229853002)(316002)(81156014)(8676002)(186003)(16526019)(5660300001)(42882007)(386003)(81166006)(26005)(3846002)(6116002)(23726003)(59450400001)(106356001)(105586002)(1076002)(6666003)(55016002)(6246003)(53936002)(9686003)(446003)(93886005)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR07MB2500;H:hc;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR07MB2500;23:FxubOqxwOVOWLOC9tCMOD/hHHKnZv5dhlHrPsnFHt?=
 =?us-ascii?Q?dq1sbSZG3hoWac+vX02yCKrTxiCJeVbmEuiAVxZAKZFjh2ohIxR8OtJpItKb?=
 =?us-ascii?Q?aCkT0fBxicjiBST1jtIzahar0vvKOO9yETq8r18LI0AHmqIPkoxO3c2+dNSO?=
 =?us-ascii?Q?8o+J6r5oNbhRLa8K0F1aUXroIgwTYx21S311/36jJyLUw/pILVO6Bera2ZWq?=
 =?us-ascii?Q?okvar6/6ilWQFTM0sYl60/lp76S4sKF4jH1NUls7qGTEDjP/grfafrZCHAI5?=
 =?us-ascii?Q?rR13NOHzv9AWvDDuPIhAynpOBXeZy7eqj8997Bmp3GwEOsyJRRh4pFht1lik?=
 =?us-ascii?Q?QvUDjleYkoscef2Vxv+T80eI+ObLaOpaBmfbVHoBLYCAf4gDdnO9UTdk5P7K?=
 =?us-ascii?Q?65CZWiOibEGfUaivLZx0a/UMQgl6ss+sF1xI8G/kFe86tqV04oyj7oPZcAzP?=
 =?us-ascii?Q?BVNmX/Nm3W6oH1JKHiMQ7+aemc52p5WUBvrenQEkmdjrcraF0+kir5y7yarb?=
 =?us-ascii?Q?ftaYi5PBO0rFm4sux+WwuA8gMfdNNasy7ovF0jD5qFv0H18HNpBWXHhfH6EX?=
 =?us-ascii?Q?jiD9UucnlqrPtJHhzpKjJhymGd2FO4zEVUWknOSuaie/99ta/PuSG4uWNtQo?=
 =?us-ascii?Q?X+nZ9Bw+yjuaOYUwZpr/MbaeD4HQa6TN2vZ9TPQaGFpLpSovx1yKgCX1qIo1?=
 =?us-ascii?Q?/ptQ86amQxxmaadBaaSlPLLwCkCZiusD/UAe828NHUdRvGJbDz6tokxYrNGZ?=
 =?us-ascii?Q?dwGYugmasdsaXSIfAFgOSVeHGhyZdxS0Qhh2xrGmjOZlOfK5KINodSlzujrP?=
 =?us-ascii?Q?1ZOyUMOPA1mijLGwWYpbFyFtTkHTUT+mwyBkDNa6w06zC0Xg99wiv29ii5j7?=
 =?us-ascii?Q?mblcKlpqZhhLys/2P+qlrAfJ/1zXGfqSXz3LjIy8kTCasVGv+fdLosXGJeFM?=
 =?us-ascii?Q?LcoCx6SsYC+bYgDFovJwF2GPbRaxImolgTVRYdOTQGCU5iWIMJiyZ+Egp/dC?=
 =?us-ascii?Q?XeBjuL2OUT5CN4LfIqzCqzshb+gUH+45nqY0TocxF7HQmvqoZWGklk+3yx/X?=
 =?us-ascii?Q?jAhpGrz1f3BeX4WYqFD4/syvxNKdaPov4tkELiF4d36z/MPujK86zXnhUNiW?=
 =?us-ascii?Q?+zM3viP1iwns+F/IlNFZjaembOY4VZEw6WQQSIJ5YW7mrstK4aXf/z76Jh2i?=
 =?us-ascii?Q?kcCxbcu4/XxnhctjoAU0YGVMkU9nxbwT77cch/pTxcfgWP9rfI2K0UGbOGut?=
 =?us-ascii?Q?p7FJC4L5rTH/bGdAXZf5EVf0I7X8Pu2SGfcaO9VxVerkbjDZU3Hw/2cKqJmO?=
 =?us-ascii?Q?IXOrDD0elFO+CMulwu2dRzH+9Py03D4B0zbeBIFCrsR4fXpsFqfIf/J76+M2?=
 =?us-ascii?Q?OyxkQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: WuaSybqk8Me9c8f7hJb1IDKs9yQUa/E3iZbLmGgpQ1Sd1V4PYCxn+nmEAdfeE6b4VeaP/nlxJV93ekHK7D7Pt4nM2IIGzPpqbkU3HNSu1J85GKgETXCh8Y8JPTB+Y1hCe6DlUA7bZuvX2U6otIHu0ZHb4Wl0iH2SBvFySO1sbfUMjsAS1is2PPXwT04efA9C
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2500;6:fSNUiaripc6mn9a4XqEC7aqHI6ILY6f/us8J9l+UAozpLBE9ONcxdWVNM7+d1kj6Oo1D8dfc6uVncujHtHwteTh4+xqpO4OL+3axR2ZnNeV/h1Z+qlViPBDIkJGtPQOW09ms/pyipYKLt3j8RiLfaFkpjIp8EkMGrIFkeHclTKtgatJ8RnP+x0LTmNbFa+PI3f4nQD2xi4mL4RLW2BTQeRJq8FmqCM3pJy4F3J3zFLFF/RMUvaOx492TTvjtvOW+zmtb2oountXBzBC7QIjOD65GFhhWnOz7PPj/hahkDtncFtpDmJI0rEzjIW+d854rzB/ofxT+3ZP+71W/0RSlb90f2ise1PfZW7bnHKI12nr0Epzp8KLLQ9LU5MRQwSr6kJFFtmSuA7ZKNaujNiQPEJ9NqDksaSSKVs9gQ9ipr3EFjTv+N/sC0n1UicksOW22agtIWbZyZoL0Yowx3zfRJA==;5:fK4R2WKEdg3l18OKMD9IRdMBGL1hKDbmxngBf52JGtvNsk0qkylKw0vlILXbeu29NvhdI9LsyYG3NnwyMItpT4C2WZMnUmIU+xIfo/JJav0HBwAWV2qjeWylHrIG7q6sb4W+ljI7KxPB7DUMSOnUZG6hI0mIzKgz89APsJvuVFQ=;24:ZFyJexBsaPyKBxTXJQoTJh6S3EGgwCEvwvRWGSTXqatmjsRh3NWfo/Z2JQ052mrRAWoP48cxw2CQ3UL0u2c2md2s4Ko4HUO5RGp+0ovAnEE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2500;7:WYFzphIcCMub7Mi0AECugDwueRSWU4zIDqdhJ78AoU4RQwh+N2TsuNhIEt+XI1P3Px6m6fdlnJqBqxa4G25jO7t4Nlu2ClmB4rn6ZwhOtMbd95V/0CX46FrS7C3QwCERG+nqyji0vRCwieipQaClmU/fGfv8kiPtGVuLZ21yQ+cNm1rtZgqB5/SW3emmJVIJDMlxtE0eMPUOOzFpIf+nHlSXDDijIkBa5fyutW4f8yK8dadNBAI6AP7jHG7xhXbr
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 08:52:23.4373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a103a99-abc9-42c6-2072-08d592f6e4f1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR07MB2500
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 03:02:01PM +0100, Jan Glauber wrote:
> On Tue, Mar 06, 2018 at 02:12:29PM +0100, Arnd Bergmann wrote:
> > On Fri, Mar 2, 2018 at 3:37 PM, Jan Glauber <jglauber@cavium.com> wrote:
> > > ThunderX1 dual socket has 96 CPUs and ThunderX2 has 224 CPUs.
> > 
> > Are you sure about those numbers? From my counting, I would have expected
> > twice that number in both cases: 48 cores, 2 chips and 2x SMT for ThunderX
> > vs 52 Cores, 2 chips and 4x SMT for ThunderX2.
> 
> That's what I have on those machines. I counted SMT as normal CPUs as it
> doesn't make a difference for the config. I've not seen SMT on ThunderX.
> 
> The ThunderX2 number of 224 is already with 4x SMT (and 2 chips) but
> there may be other versions planned that I'm not aware of.
> 
> > > Therefore raise the default number of CPUs from 64 to 256
> > > by adding an arm64 specific option to override the generic default.
> > 
> > Regardless of what the correct numbers for your chips are, I'd like
> > to hear some other opinions on how high we should raise that default
> > limit, both in arch/arm64/Kconfig and in the defconfig file.
> > 
> > As I remember it, there is a noticeable cost for taking the limit beyond
> > BITS_PER_LONG, both in terms of memory consumption and also
> > runtime performance (copying and comparing CPU masks).
> 
> OK, that explains the default. My unverified assumption is that
> increasing the CPU masks wont be a noticable performance hit.
> 
> Also, I don't think that anyone who wants performance will use
> defconfig. All server distributions would bump up the NR_CPUS anyway
> and really small systems will probably need to tune the config
> anyway.
> 
> For me defconfig should produce a usable system, not with every last
> driver configured but with all the basics like CPUs, networking, etc.
> fully present.
> 
> > I'm sure someone will keep coming up with even larger configurations
> > in the future, so we should try to decide how far we can take the
> > defaults for the moment without impacting users of the smallest
> > systems. Alternatively, you could add some measurements that
> > show how much memory and CPU time is used up on a typical
> > configuration for a small system (4 cores, no SMT, 512 MB RAM).
> > If that's low enough, we could just do it anyway.
> 
> OK, I'll take a look.

I've made some measurements on a 4 core board (Cavium 81xx) with
NR_CPUS set to 64 or 256:

- vmlinux grows by 0.04 % with 256 CPUs

- Kernel compile time was a bit faster with 256 CPUS (which does
  not make sense, but at least is seems to not suffer from the change).
  Is there a benchmark that will be better suited? Maybe even a
  microbenchmark that will suffer from the longer cpumasks?

- Available memory decreased by 0.13% (restricted memory to 512 MB),
  BSS increased 5.3 %

Cheers,
Jan
