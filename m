Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751663AbeEDJaQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 05:30:16 -0400
Received: from mail-sn1nam02on0062.outbound.protection.outlook.com ([104.47.36.62]:39776
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751239AbeEDJaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 05:30:14 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@cavium.com;
Date: Fri, 4 May 2018 11:30:02 +0200
From: Robert Richter <robert.richter@cavium.com>
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, Huacai Chen <chenhc@lemote.com>,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Robert Richter <rric@kernel.org>, oprofile-list@lists.sf.net
Subject: Re: [RFC PATCH] MIPS: Oprofile: Drop support
Message-ID: <20180504093002.GC4493@rric.localdomain>
References: <1524574554-7451-1-git-send-email-matt.redfearn@mips.com>
 <20180424130511.GB28813@saruman>
 <5e464a40-4e4d-dde4-b5b5-ceb637dc5f38@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e464a40-4e4d-dde4-b5b5-ceb637dc5f38@mips.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [78.55.252.79]
X-ClientProxiedBy: AM5PR0601CA0035.eurprd06.prod.outlook.com
 (2603:10a6:203:68::21) To BLUPR0701MB0995.namprd07.prod.outlook.com
 (2a01:111:e400:8aa::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:BLUPR0701MB0995;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB0995;3:MM/UK2unqBOnKhtsTT6IVFM7LUC2H+FMH2aMs/95Bl3k9nd9g3SS3RpMD7XfI/k9mfWxopVrcSUWE0UCUqgeK+A9+4V1nqtFDk6ojXUdJ8Qg2k64dm3tc1m5SVd6tdW6BDzz8DIGNG4SeOyptFiE/OCb7lmdqz7dklCW0wUXHi1yjxdidFq16MkZyohzMapqTHJsMKWPRcbhqTd1PnV5uRJHFZqdebltH0ysjZODKK/LWdRBSG0DxxEANwUzZHRo;25:81erbLv9Maf4P/ieaVuAd/PVT2iFkD3v2gohviVHEw6wz/HrY5uYM+PhkUkfPaBJveOe5+l3jVD6EIjzBpjfZ8fvtwab97K7sm0rPiFJcowOTTlLjPvAAd9CxzBOlugv3ustCLDa1ZmnMydLninNx/a5ma0DogzAiq9gqhHVTXOkZVxxPe+5Ioh6OofjUY9+8OX80/ltDo/L+yIA+303KSxDVQkytfC3IGuKBSyeH484NWqQtzO38td2wRn5LMqjjeL47I/EKYpLAK8hJ3iNDhFxtVrc4Zq4QgkQw4tcYTWKy+QMOJaB2Z31PKw0XFKPLmlGq+1BE5A72X0tuRfwnA==;31:xvtPW2dRyD5gU8NlwG5vaoxSFIsbsVoKt8XORggc0xux7dNT+GuLZRDIEnGp59rmMXRzUtJZRBgMx+uDdTf1ufBPbQbuLLihsZltrIVJtoY4UfiJgcDmmGSsurOwjUlhL30FozRyyXemVuJ5rMAhmVQIs+x46/uiLDzbOhKnI2FL60honJL+prYK7AqTkAcn76iRH6k76+Lh3A7J6CbKDc4fpmJNuX6u2PwzyqfNEnQ=
X-MS-TrafficTypeDiagnostic: BLUPR0701MB0995:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB0995;20:h8FqVNbFB5lhpQsKJLq9D8//EMzBeqdYMf33KzxLEUFMjNdTNJVS1cw7Ee89WDzPtuDFNbSBXUfT8sW5avUnihKctiSHHWDp2GrrtpPYxMoIfQd+RJugK3oHQaWuuqaDj703MHMOyR92Rv1E/JeohOs7ZFoNGF74p5Hoa60TC+Oq5mKFvswUEqZPen5F2rAczQUpKCH0WlMI4l1WCaQFVx9r9FGjnCdaHkOjtZQTDREBsJl7pnSpUPyjbyqL7PJJPyY1/SZ59oF/haoBPZgz3SMuvClAxl4tJRP516OkXPdTgznu0CQelnwHhmqCoExm875thHOtNcrkmEZBQWyMhKmZwu+Fp2azDOJRUSkR9a6AyFrQ40hxqxMyXNmZWxAEvSjHFUXF7uo9sjk0NXFNKq6hKshYPdDxRBACc/5K7bO5rWPsYDPAljR3F33pZZIFQ/unnQEiiZ9JPggxpphaM6JaQF0OGTjVP5pZs3JiMV1xdRq7gJxjhvthiDDYHb22;4:Rj9eP8tw2nYaBeZ6xP8bsixHWMGZr4v/de1XOgzctX11fUg7KOhnzfld8E6962zvXEBx7GG0ugxff0wcAmoT4OqgSI9ug5FjWcghOXyoFzdFKjUJBRPmbi6E/wQnVRQQK5IE3TP+WCNcFVqcEMPJinV8yJmzC+WsnOYCy8qdcRTkRvlaL0f0U6kA1CIh85LM2uS3g8vk9wwNN+Sb+rNv3dUzxRn4vgceJhca6rsHdfr86/elJ7e1utxUXoGK9UPD+qxr+R3IWG7Tk+qC7/33WcYQCNlWK6Js2jU3SYRbpAH0bNO2racyFlGfFjrL9+OL
X-Microsoft-Antispam-PRVS: <BLUPR0701MB0995E26B56C682E8FAB4CEC3F1860@BLUPR0701MB0995.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(42262312472803);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BLUPR0701MB0995;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB0995;
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39380400002)(39850400004)(366004)(199004)(189003)(106356001)(54906003)(72206003)(305945005)(105586002)(7736002)(8676002)(81156014)(478600001)(229853002)(6916009)(6246003)(81166006)(8936002)(7696005)(68736007)(6666003)(316002)(16586007)(58126008)(76176011)(52116002)(2906002)(7416002)(3846002)(33896004)(956004)(53546011)(53936002)(186003)(16526019)(47776003)(966005)(5660300001)(1076002)(25786009)(386003)(66066001)(4326008)(446003)(44832011)(476003)(97736004)(23726003)(575784001)(33656002)(6306002)(486006)(86362001)(6116002)(26005)(11346002)(50466002)(55016002)(9686003)(6506007)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0701MB0995;H:rric.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0701MB0995;23:3ih/1Mgdh2y/W7VfkYTOrIJ/IX5Przb9Om9gXfP?=
 =?us-ascii?Q?Z9pJLpvOnnUx6vIGxebI0V1MLz2tb5dhZ9g1Wv2g5x/gNyQFxEJicPNXtHTY?=
 =?us-ascii?Q?fEAADitSa8+OEZIMJBYY3rhQ2B0Q2B9iiyWMge/SSXRhMGr0OnW/7B21Vwnz?=
 =?us-ascii?Q?bWCfeEw7axB5Trn8XlrdJqEeCOOmQBWOBzO4ma2MVPIJZiNFjgvhz/YiAiZJ?=
 =?us-ascii?Q?Nv0gQFIJOyOPth+ts4pWDVBnJCmYuQYWdYp/pMoUX2IHqYgEw86unkv/wo//?=
 =?us-ascii?Q?qyc5vDsT0VibU7UdoPncz1AwleNia8N3fRbbismnsezHD7Z9PShy9gumpp2c?=
 =?us-ascii?Q?+JY5swMdgmfcbSCuPT7+HZmc+40QX6I5AxTMA/ELVmqK5cTbPqveEtxkOrsN?=
 =?us-ascii?Q?gCa3nHLXXP86+dtVhmWePE2jpwOzN2cltr++IjaEtww1t9z1T3TfZ8Wx85PY?=
 =?us-ascii?Q?KO+Y4UpxunKmGJf1VKSktcspiM2A0CWYY5bb0f/8Jc5ZQZBMZILnr6TXmZ0v?=
 =?us-ascii?Q?OdLrM5Et1eMQ2Vn0I7wctyRMKDkP441/xbmsKWcASqnF+x75dWUWgQiZbDk4?=
 =?us-ascii?Q?C7QCuPPODC491DW8trNoG70erDBeD23kyiYqeZGf+sw50imROoxdBWZPrvuj?=
 =?us-ascii?Q?HWi+iH9jOORPitLVJJf1nbS1YBUCObai9BZ66/tO7aAkn36a6tCBE7kYsu0/?=
 =?us-ascii?Q?0u/KIPduGVWO43nCHUurv2VGGSCIruOBU3atnRrEsGAYyGvOaI5Lnw2RMXdj?=
 =?us-ascii?Q?Ar+WCL30bXpJgCfZh6dULsgc1QQNehyWK6RPD8gsAot5MutU/+PasTAbArXa?=
 =?us-ascii?Q?K+tf949aJ0GnIzaLQsbiNRHfK1EZzxmxgthrIAkbsxLmAs6yZG4Dk26j+ciZ?=
 =?us-ascii?Q?AI9VfkTgIidC2AKL0HIfTZgxOvcH6JeWUCW0n5kx6I53MtuIb5R841IT1EV9?=
 =?us-ascii?Q?jRA33PajKd5rRmn9e9aIlkRb03hagJGEYXhiifQrC69J/ggs6xo7c83wERPB?=
 =?us-ascii?Q?tVAN2t26EsBK7rsMObyM9ZuMsHM+1U4Lw2IPg/Ivz5tAwJ483aHLX1KP3vFF?=
 =?us-ascii?Q?B+t1qBvLfKRaFK68QPUkL7mhb7nyZP/vlGd4cguCme0yESsRGRzE7h0UAPcz?=
 =?us-ascii?Q?OprBArIVxn3Jw43vAjB93yDxZgWOrl5U+0cExXqQzZHRDXBd+xvAAG5IwWyu?=
 =?us-ascii?Q?XhcVxvhD1WUHtJkncGi4403Ffm0fN3vikKkQr+76Russ5cWsF+hZ9isTMZBA?=
 =?us-ascii?Q?VK3EYctPbVVDXLumzlViazYSDzv1zUt1tZGk/eN2BSKDwnwQc+W2JRFsu14A?=
 =?us-ascii?Q?gM0J5ELcz7zKDuEfGQeD26e9N+DWnFts4lTS/2+NN+XzAA7NtEZ6MPBMx5Cb?=
 =?us-ascii?Q?IwbIFzUrjuTeoeL2KCwbbgEluEagxhAWgeVKQ/ZXW0tKPAuGS9ik/TFviw6m?=
 =?us-ascii?Q?xjcOPWA7zdg=3D=3D?=
X-Microsoft-Antispam-Message-Info: qfL0pCidSGbyN5+rWlbmQMHGxNe5K9JJW/9jfDHciHqk/6WN3FOfKALyz65JZtNZdPcrOdKRsN8W5C3/2+ds0EtHAwbcV3QHLPcqw0kxf3YBu+fNZtgPHQ9Le4f2wJcxb+WQSUO/6qRLQVqh9R44BILsE+ZkzH4t/tuGI3mwRYhrbQ3HucweI/fU9dJgAByX
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB0995;6:zElyD//8KjAlHV3zhXI71hX2WVGk6LMVluKL9fCffEDf+Edi15w4Pje+Wlqov3qsQqC6SwUXfwOBQ5Eq+52y/KPr9/onMj7NvomgXGCKa1VHkBMsfC169DbxX7Ao7YtYFJKoPBErACNoBrUsH9YaW0lq2laUdd6o9nkwCPnvkt5bxVbfYNgrQecbdZcwolGbRgzQ7v+UikqMQU+lD/r8udL2/8p6VvTwJnRBtQxz7ejbERZNpGj+2nhrZzEM/m3mEOyswVPbMpncffW4vWJhU3WEQxuHzEUhjnOFbGeBYtEfffXqNw0W41Gz30WRjndGby2V/875Nwew0MoHc//mjSLP4WeE5HU64O09c1IH6iKrBOzjMtGIYBDCqCWLMnOIlhIAQ/t0/YosL+3ZBqGnV7lII5MZW9Qi21ptx+Q2pG2Qm8Jdj8KoGgoOLJJGDPN930EKHdWvDA/41NfS7vNw6Q==;5:eW8j053JlZm8gH7HqYBqpncSGaOznKdYB9RDBGWBduDAHx17Pbs1xuBD1x4RYZ4Ug2vvA3Nfl+MzQlElp271WlOWMzgNT5tM1cDme6opUaLU/CGg1sNToh+/zAI48QHg+Kjgn1FmCzJnMRcQp2AbMoEdUiTQD4Kyl3hvsXohIkI=;24:u8hh/Sg7QWSsW7LQsYJ4UgZgeUfqJVzoxVkkYk3XGePUbPrvxStQHMU/g7zw0Z56fA3FOaYvnrUWAX6jmtRGmtYUL2whbV0lISp0DO571nI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB0995;7:GGuB/qwdY13qBtO1eoeYmOpTA5Vn1B+80yc4pPa8KdurlIvj4gaf41eV07D8jvlKyG4ZAn8C0z6jDcGfvJcaR+/B0gpK0HmklS9fxwoRt+upjXpfbpzhvRItA4liH2yc7ISPX1fxn+IIcXlgZecspkfnrRl69y1Bwk+QSNrnkPo2wzq5fgRQKh6MT+vagiX4olq7bL8sZh9fub1ryHEIqZQhgPUWSrjPtXuzfZk2dGAQxvn+0v70nJOat2sf5vja
X-MS-Office365-Filtering-Correlation-Id: 27dfdc99-577a-48ff-b1ee-08d5b1a1a333
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 09:30:11.5124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27dfdc99-577a-48ff-b1ee-08d5b1a1a333
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0701MB0995
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.04.18 14:15:58, Matt Redfearn wrote:
> On 24/04/18 14:05, James Hogan wrote:
> >On Tue, Apr 24, 2018 at 01:55:54PM +0100, Matt Redfearn wrote:
> >>Since it appears that MIPS oprofile support is currently broken, core
> >>oprofile is not getting many updates and not as many architectures
> >>implement support for it compared to perf, remove the MIPS support.
> >
> >That sounds reasonable to me. Any idea how long its been broken?
> 
> Sorry, not yet. I haven't yet looked into where/how it's broken that would
> narrow that down...

oprofile moved to perf syscall as kernel i/f with version 1.0.0. The
opcontrol script that was using the oprofile kernel i/f was removed:

 https://sourceforge.net/p/oprofile/oprofile/ci/0c142c3a096d3e9ec42cc9b0ddad994fea60d135/

Thus, cpus that do not support the perf syscall are no longer
supported by 1.x releases.

 https://sourceforge.net/p/oprofile/oprofile/ci/797d01dea0b82dbbdb0c21112a3de75990e011d2/

For those remainings there is still version 0.9.x available (tagged
PRE_RELEASE_1_0).

I am undecided whether removing oprofile kernel i/f falls under the
rule of "never break user space" here. Strictly seen, yes it breaks
those remainings. So if the perf syscall is not available as an
alternative, the oprofile kernel support shouldn't be removed.

-Robert
