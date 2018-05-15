Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbeEOCaa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 22:30:30 -0400
Received: from mail-by2nam01on0048.outbound.protection.outlook.com ([104.47.34.48]:50624
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752024AbeEOCa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 22:30:27 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Tue, 15 May 2018 10:29:39 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Thomas Hebb <tommyhebb@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Synaptics
        Berlin SoC support),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: Re: [PATCH] ARM: dts: chromecast: override bad bootloader memory
 info
Message-ID: <20180515102939.3ab8797c@xhacker.debian>
In-Reply-To: <20180514215645.17592-2-tommyhebb@gmail.com>
References: <20180514215645.17592-2-tommyhebb@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR01CA0019.jpnprd01.prod.outlook.com
 (2603:1096:404:a::31) To DM5PR03MB2634.namprd03.prod.outlook.com
 (2603:10b6:3:43::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2634;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2634;3:kQ4VVhQlV24EH4uZXtCysDZjQtJzNph7ToTEuD4ZnVDEYp6Rj/O25slMn+tbm8l2aTEYvVTPh6+4OafsY0AuYQyOAPL02uvIdLISHhNNFxgrjYPxNiyBREO7i0gUMZW88m48FEyd7DN5ePZAxxdHFgJDLpiBl9ZaJIgbFKEPEj2o5MuksJfjJEK9r0jZXpNLb8YS6TxYKcvUNUerassuqagx78NdZGHtVVlc3wXDNz57APnXZpocfpaWso1Om5Dv;25:DP4W0GI4SQZJoNpyHZtTSRXzOCi897iDCQkMMXYGmuZS+Pn5VcjMaLLvTQPnwjt0kGW6hDmQeSLDqCVpkaJaZi7LHMjf69eTKxqJ/XW7x4J5W5GG0M+UItvlzs3XUl6u/xi2kqsvxwJATtTH4FTR7O/WhnEKDhlR6jBeqAqxOrVvnhu+HasW218UJwM0LqYV1tYBdgk5Rod25tLCclafk9dkC1yb8v81gA9kTwegyhO8fOC1wfwtnB++0PzrGUVA26MN9Kioi6aQ0YT570Fr/k+G/I3GrmnGaM3m2Qpgiomn/JNCWGI5XNcCAXcGQzQn26pVISOCy5wZcGuBtPf0OQ==;31:6MZ4S8yk27/QCQc8zTJ/ojDqW08tfKzNZt5EzLAOrWSBxFuPz6fmAA9o1wlr8WiXa8hDF5TIHPyeEtIwQLFrBbpeEepr+oiWf0TKl7R7Cbnojs7B0NqSrve8RstIGMYfik39Q2Py3KSEY3zW+w+4xgRJDZVBOUaxLSa5tl1QAqiGqW+jtaXWKN5Phn6XVpoWSO4rwU5zhztGX4X3gOqsB/UCald08GHPF7isuuMb16I=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2634:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2634;20:FK0St9blPsgrDV9V12wfxKs/Ny82FJ0l7TQsKjh6iaw6J4oOtVhkGhDQHlespbK+W3/VB2Up5bObUcA1SwB2l7qsxmOZCP7qbuL2ux3vpNx192kJqlZKACcVskkRk+eOilAEB8ckbXJwKbGvMZ3Vsd/Ws3KueDcwNOThMQiz8BXWrxJ6SP5uMx19Mdil1HWr7bZ3h7RuE8pPUXH2cA1lwSwZd2wQj1aKDd2GZQ1ciWZu+uayAaNkI3+bgf2hjWvXf+FU2BwOBYTR3Po+cfPp8H6vClo4/2q0XMoYzNkMui2Lw5I2AwoU+3BDclbjfuq3ESAKY+rtldwutYVv6+MtjGazGVwSO87vyn5iHX2T87nlp9cmw/xJgTdBoi3XG4V/RBTv6MT5lbCB6EK5oUIbe71nXeKbm9T7n5NttMtTo3aLkTCGMF/vp2A/kwzESksZYZ36Yshkc4szKYDlPc/JQ9KW0TLbSbqvUTzbnzk71WceYbbu8VXL94TVoagQmJcE;4:co+ZFMrfD1ndDfRUWFQ41CC9IKfqi6URS8nDeuF7lPRlsoxqxqIkR/IL4fwafxHh7QdCvfFqJfeeUgKCFVpV8bKjNkgpkuNJ7AAstPJrAnTZK20GX8MmUJ966TAfzUXaSJikxmcDpEuDksm4VqNLrVIvitWVQp2GVdqvtC03t20B7bz0jV0JM75moHPTszzj2uV+3S1xq21xgJ5W79yStDjmXTJF1BcYmeb43K3g2i14Q/A6DNcVDp5iovAWt7wa8sOpeNQ39dU1jJIR/+q84VtwMEszrljDoFyvQSFwqxLWjrWaiQFA+ibyR9ykDEz0
X-Microsoft-Antispam-PRVS: <DM5PR03MB2634C5E43658DB7942B18FB6ED930@DM5PR03MB2634.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR03MB2634;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2634;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(346002)(39860400002)(396003)(366004)(199004)(189003)(7736002)(39060400002)(305945005)(1411001)(4326008)(386003)(59450400001)(6506007)(25786009)(5660300001)(26005)(72206003)(53936002)(6916009)(478600001)(6246003)(316002)(6666003)(97736004)(54906003)(76176011)(7696005)(52116002)(1076002)(229853002)(33896004)(230700001)(476003)(956004)(11346002)(446003)(50226002)(47776003)(3846002)(105586002)(68736007)(81166006)(6116002)(106356001)(81156014)(66066001)(23726003)(55016002)(486006)(9686003)(50466002)(86362001)(186003)(2906002)(8936002)(8676002)(16526019)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2634;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2634;23:MK/5ir1GlcRQdnzMEDkNoq2YVnhCNEvpq2LHGlmCs?=
 =?us-ascii?Q?nMj1j3BHc0J6beQDmqBJAOus6RXKjrn1kDVN7ZqVrYE6+fBGYDgNrA60B5A9?=
 =?us-ascii?Q?MFI2boXcez/538lrXYjivuJO9qsKS9S/GZdNAYUzNze+dOD61zFGAX4Mmuag?=
 =?us-ascii?Q?xws9EYOl6OrmseLZhsfxAXWi1hVQIBqfbXAWx81NUtzvmuNEkhRHeeHIVL4S?=
 =?us-ascii?Q?//13iWwIWTdg9S4l83ytkOjv/EXFYTBKTLMBRD51n9RZQkqqbjZOUjp0JEXM?=
 =?us-ascii?Q?G4d77Lb2mWoyEWbZWH4iOiuk0NSNv38eih1YtmxskKQDw3fPh9PEqz04Snou?=
 =?us-ascii?Q?752aKcmzcC3qYUqAnO2RZcixcheh/fARET7K1CWrIYBsmmEBlBYdjw1bmAQA?=
 =?us-ascii?Q?Rten9gTmIEZWOXaL4jPol3y8zt1aDkXpbqN9hUB2SskFVApKLykpqM5gKSb1?=
 =?us-ascii?Q?FIJ1GTBvX1bmg+6S3VlZ68aE+S8kp3ynmRU21LOxHCUtgIoE4D+tE0k2aNtL?=
 =?us-ascii?Q?0eQLQDVzj2X8laJqZGRzix7CncIk3kzNsyRruFfmb39SN4WxZuYWiV8RZ8Ep?=
 =?us-ascii?Q?nntk4MB0lihyInUSSGsWgOZupA0EE//cvwfDtOl9PAg+I0XGm6JjP8g4XUvJ?=
 =?us-ascii?Q?SDS93h4PRYHmhAoYS67RPXzR6ZTmQuTnkh69/lGHIAiQV1Ii+1mqvVI5pWkA?=
 =?us-ascii?Q?ZJ4ksOm6y3+WvzFH1QJPLeVQ8JAEBCn2BqcnhjCAvygnlzKsWjYmMTsE96eI?=
 =?us-ascii?Q?bF7SV+7e3NeBjK//Mo2B4Z/xJB37W4zADougLTHGFrl7PFBTN/QQBy+tR27J?=
 =?us-ascii?Q?pWoH44EYXHzBUixRDvN7YYwfISx4n/V2WCtiEXKoVmDO/engfMkTo6Pk2J6w?=
 =?us-ascii?Q?+5aZh/QVvMy7KM5XmA+iG/Hg4lPRNPIKjIru59f7izs5OiLRvXqd4xaxXRNY?=
 =?us-ascii?Q?JfWlw8w1xYmeP5ZgFLm2J3/4ystBIhhATxKF/vrms2FLw8ugjk21X7W04Wj5?=
 =?us-ascii?Q?CGcc/6A8Qemi0c50iNGDb0YVJl1oPn0Olz4IeWCzmtsljn5ntaBJREXoDEsO?=
 =?us-ascii?Q?+2qVqXD5AHsq1c83kLBXW3CM8rniaWiHhMeLvykTst6/6z/aNMdQ5AHL1SkR?=
 =?us-ascii?Q?jMDGad42MtaxHFo63rxKdtACTicMLIXnYCoz0CznfJkYZ+ueZhJ7wEGLcF9F?=
 =?us-ascii?Q?FP9iMWj/Q4DkGo2rSHtud/1oSPBQkXMOkkq1ZFB+sxE6rvdISQ5DIKXzLPio?=
 =?us-ascii?Q?71WZdM1CSnXQRXH27nrbrCdpIZcljRTTCmD69dMBGfiINf/fTITN96apm3mi?=
 =?us-ascii?Q?yIx4wL7VSzJ6zB7lb5FfAm4q89CWcnrj2pWwmtG3QSxhxHc2RryfbWxmZXK+?=
 =?us-ascii?Q?ShF1Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: twKRTySbsVjQL9MBOXJ3BYHms0asH/mBKW7ky2ayicTSJEhxkJaFLO96D2o6RFjjQIN5fTrmvh5SZa9AzyPLnBvXHAM6sXBAnYs+rhZDkvOXMx31z74XmSvKtaZ2qQHsQtWlUJajyw0+XbHcZ2KQXfp2W3R8NdE30598cruwjd7AtaToMhESesIoC4EBNn48
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2634;6:Fvv8ZDwa4nC868pcojC0ZxzfwrziSofcLHCTKV0quQ8sJW4PE9tCuAUjb255rW+Hgn0t+xqUf8FgQz1ktDLxcU3QHKw1fnxiyJitkYIj954F13UVml3f5ax4baPaIhTmfBpBrG/3ZBlZyH1V7xV4+AWbDgtChFKvP+8Bi4eP5fH7iktOf8+elJWM9e+bbb9ppAiRDwmZuW21+yoRt8JH9xWRRA+k9hVlKtGAscuEPDSdXE/B4Qelrq/vn/6CiBoR7XG/yfkOYGllbcXCjyxM1rYQYGrrcNWaznLDcYoZNaoLRzcdgd7CajbL/HluLipydyCHduGx3zCJH6l7leUd5cQ7GbGpd9rjiiZR5bIeza8NfRBTxd/cVaJ7EME46Ec/KrYAqcgnnqGvUPrazEUhEv0odt4k89lXIq6aio4K80MrRoHniXt4bqdSgTjAvgBA26t4B++x+BckisMfmuUKyA==;5:PNRwxzhWYL/N2oZm0BauWVCp16RzZ/A2Kz5d9bRlO8lH5CAIgdPmFNvkbvrAD5hrjwEqHa7AXKXcJLFdY1POfiQ269GD7vhC69+0k+TuUVXnYHUIzwSsC/dCLDqiedGuCN97Q5YvoKenccOIalWUBamHzb9qu3BPHrlQ6pDweQg=;24:eI8xuFhGnbAO/59e/c9OquHweLpXSjzbh1mxd7IJ2iaT1Mm6r/URL8h/dwusxYuIG2ppochKgA11CSRYyNA8qoxPO9uS2YCx+0KbwKgiAYA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2634;7:fm/JF700O1Ssl/epR2o/AC2nX79FnevI/gaJYPNQL4n4nL2YJy3ec/t1AoaoLsemUWdpCp6PwxnTxt111UNt5fYsLzr6ODZ1YTU2wvsM2oz7daFMaqKY3k90rXvLuiggCu8iKdnOHxIxvWxNgzZWbmavc9eyqWdQEYUkfY5tK1iEW7i6k2ruwYY6CH6PMuhCFYJELaR3jlUzJa6SGVffk5zUc7AgaY/e+YTkf0591jxCOPNE8+zBXmokbGKg2igS
X-MS-Office365-Filtering-Correlation-Id: fb7ee39c-c196-418c-5b88-08d5ba0bd0a7
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 02:30:23.1141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7ee39c-c196-418c-5b88-08d5ba0bd0a7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2634
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 14 May 2018 17:56:45 -0400 Thomas Hebb  wrote:

> On the Chromecast, the bootloader provides us with an ATAG_MEM of
> start=0x01000000 and size=0x3eff8000. This is clearly incorrect, as the
> range given encompasses nearly a GiB but the Chromecast only has 512MiB
> of RAM! Additionally, this causes the kernel to be decompressed at
> 0x00008000, below the claimed beginning of RAM, and so the boot fails.
> 
> Since the existing ATAG parsing code runs before the kernel is even
> decompressed and irrevocably patches the device tree, don't even try

This means you enabled ARM_ATAG_DTB_COMPAT. could we disable it instead?
The ATAG is useless when we provide dtb. And IIRC, the ATAG is provided due
to legacy history code.

Thanks

> to bypass it. Instead, use the "linux,usable-memory" property instead
> of the "reg" property to define the real range. The ATAG code only
> overwrites reg, but linux,usable-memory is checked first in the OF
> driver, so the fact that reg gets changed makes no difference.
> 
> Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
> ---
>  arch/arm/boot/dts/berlin2cd-google-chromecast.dts | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
> index 20f31cdeaf38..54221f55bfa2 100644
> --- a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
> +++ b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
> @@ -52,7 +52,17 @@
>  
>  	memory@0 {
>  		device_type = "memory";
> -		reg = <0x00000000 0x20000000>; /* 512 MB */
> +
> +		/*
> +		 * We're using "linux,usable-memory" instead of "reg" here
> +		 * because the (signed and encrypted) bootloader that shipped
> +		 * with this device provides an incorrect memory range in
> +		 * ATAG_MEM. Linux helpfully overrides the "reg" property with
> +		 * data from the ATAG, so we can't specify the proper range
> +		 * normally. Fortunately, this alternate property is checked
> +		 * first by the OF driver, so we can (ab)use it instead.
> +		 */
> +		linux,usable-memory = <0x00000000 0x20000000>; /* 512 MB */
>  	};
>  
>  	leds {
