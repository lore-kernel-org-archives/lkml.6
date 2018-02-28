Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753161AbeB1Szt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 13:55:49 -0500
Received: from mail-bl2nam02on0040.outbound.protection.outlook.com ([104.47.38.40]:35982
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753137AbeB1Szq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 13:55:46 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
Message-ID: <1519838731.16494.8.camel@nxp.com>
Subject: Re: [PATCH V4 2/2] thermal: imx: add i.MX7 thermal sensor support
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Anson Huang <Anson.Huang@nxp.com>, <rui.zhang@intel.com>,
        <edubezval@gmail.com>, <shawnguo@kernel.org>
CC: <Linux-imx@nxp.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <fabio.estevam@nxp.com>,
        <linux@armlinux.org.uk>, <kernel@pengutronix.de>,
        Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Date: Wed, 28 Feb 2018 19:25:31 +0200
In-Reply-To: <1519459369-29083-2-git-send-email-Anson.Huang@nxp.com>
References: <1519459369-29083-1-git-send-email-Anson.Huang@nxp.com>
         <1519459369-29083-2-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131643177445388695;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(396003)(346002)(39380400002)(39860400002)(376002)(2980300002)(1110001)(1109001)(339900001)(377424004)(199004)(189003)(956003)(76176011)(59450400001)(81156014)(47776003)(97736004)(110136005)(8676002)(54906003)(316002)(68736007)(26826003)(450100002)(336011)(36756003)(26005)(2906002)(229853002)(2870700001)(104016004)(498600001)(107886003)(50226002)(5660300001)(2950100002)(2201001)(53936002)(86362001)(8936002)(4326008)(6246003)(23676004)(85426001)(5820100001)(105606002)(50466002)(103116003)(305945005)(106466001)(81166006)(356003)(99106002)(42866002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR03MB1421;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11OLC005;1:lxQzkv6X9RNQYpKRtgoXCZlMDkss/GITJ8yluXdWdWqtWUlAQutitd10YIIJ7CONsNPla/1UOf7JPdhptifsPsqg19NA2W+ZhBSH8bUJ3SBlKECT5TK0GVVAg4T8wrkw
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6bac093-288e-4ed2-7197-08d57edcdf33
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:CY1PR03MB1421;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB1421;3:eXCADCTPpgu2BHZrIGnVqkLRYuVgS9jSl599Fxrg8UHZ6t6AmGKD9nb+HtpFmJuWmzbdnOrg9r1khAVp4FF18sVyBNKeQSgm24VeO92yz26TjHuVcoe8avFtPP3/7fFj2qoBI5WqXPGGsvu/Hpyz+POSbO646625VxOcpqpgD7B+odO9b8vsSNMoVnPs9LB0nml+VsM63iox9HEcx8BvRPmsSIKeULyK2mLJyv1x2ETiLjSHxhcXDBGUCW7rKXPqJmBh/2tZ8IARJqM2kiqRtqrFeeZy6ImVI2T2kwAM3Qnq2yewM291Cs//U3YaVpWE9qTQpiBl0+EEXy7qVxIeAYCTcLA2lj6HF/CoIGmGcAQ=;25:BrcacUntykQ4TDwXfmj1nkxL0NMHkMltVSPMN9m/FEH0D+FVNq0LwhP4kJc8am1RsAYpwmKjcAFz+JoULM7bv0HnTVfOUlmOj8YsAIuc/AcFJTAcKqP9TNgNUjdVzVJlIh51736cNVswbEzCxM8Y/QMWgzvDhe10TZ9ndNmdS/IE11lluEcbK2AejLP+Y4xBaa+lpaFifVQcvueGxsmOMLcrYesdY1uY2B9OLV17isziFcLz72FoTEsmwHUknnIOVx+VcZuqEsNnfiryB8pSLCtutiyWNYuQvklSYgm9hltTacgcUD+0CylBCnrMGTQ16zm79mssFzhn9zZEzILYHQ==
X-MS-TrafficTypeDiagnostic: CY1PR03MB1421:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB1421;31:EbFI9HMIWKeTnMUk1GcNSA9V5xTn7wlLMKlWFFGGJeAUZVyW72O1ry/VZnJYr6ed3Qa7ylQm7Wc0bnSW+TAnzYOCPxHdJvj2Y56iuADszNO63W+yjr7QheIPhumwUYd0dt69SzB9OXA4CbEbybtlGum8A4/eV/UKf0syTEXHBqYkg0WJbyV0DYebwO9vbR8K21a4LLcWM+uxbfrU67eUynEcUX60ElgCbcEXFlDqjgs=;4:onnNOv8JnS9x+TiJVqPcBQZKSG4pco0pejxBY3iPuIy84msFgMu2c/KRQmTIgsptKXKZFyQ5exO/H36/mjAND6mt7VU/+IjrBRVnRXdJYY1K2WEW/IyEQBr/gmSCPncmdO9LHouC7udSkd1x6HpL8ejOJfC+wLzr6p/uVzXr+nl04y9uJDbADWvDsoPpY0M2MWJT5D+o8qPwONEsdfbPlivMsCdl+jOXCoDItD8NrxgPWB/9sVKRTmqUmJWR/i9z/47QBr9m+rK8pKcu40Mjm1dKXtU6IXFxOLelf0YYCUkRQUlsqe9dN63DPC+oldve
X-Microsoft-Antispam-PRVS: <CY1PR03MB14212EF88F2336AB6D20ADB8EEC70@CY1PR03MB1421.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231220)(944501161)(10201501046)(3002001)(6055026)(6096035)(20161123561025)(20161123563025)(20161123559100)(20161123556025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123565025)(201708071742011);SRVR:CY1PR03MB1421;BCL:0;PCL:0;RULEID:(400006);SRVR:CY1PR03MB1421;
X-Forefront-PRVS: 0597911EE1
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjAzTUIxNDIxOzIzOmZlU0hzVFVxTWlrNlllR0VxdVpUNkttWDYr?=
 =?utf-8?B?TjlsdmZHU0lnVTl3VTgwUTNaTVFJSGNZK3hxWjFoUXJiQ2RjNlFwb0lFc216?=
 =?utf-8?B?QTBpNjYrVzRDOFk3ZHBDb1F0akNlYXhHYTV2RW5DR0VadGRNb2tvUnh3cGh3?=
 =?utf-8?B?ejVvMXpaRE95dEZ0dUpFZmROdC9NckVnV3J0eitZSTh5TGlscTlRTFVXRHQx?=
 =?utf-8?B?YTJ0T0kybjBMZ2dPWG4zNUJoME1iYUJ0TE5YZkVLZWkrSkljd1BvRFd2aytn?=
 =?utf-8?B?NVh3d0RhWVI4TjVJcGZWeDhZd0NHOFdmdXNpRU5qQitheUVhTmxqaTYybXIx?=
 =?utf-8?B?NW1tZHBpMzBQUjhYMm4wTXZRNTBINlpRZ2hmTjM1NXNWSWlrd2JsMnA3WjFV?=
 =?utf-8?B?bkg4emxQQkxRYmt0cElMVXl6WEZoQ2VXS2tvOGR0d1FsSVNuck4zVitWZ1hl?=
 =?utf-8?B?dWFucHVWU0p2NGdJSWI4OWw1aG11Y05RTHgrMmtkMm0zeDJOSDlwdmJyWVFv?=
 =?utf-8?B?MEZ2bXNOS3FKekswWGtiZExTTjBMSXpHeldVaVhNalNBMWJHOE1LK2l4NG9p?=
 =?utf-8?B?WnFCWVBMS1lya1RtRDBuZjE4aVpNR0dqcDd6RFFlWTlVMzdiY3VNSUpVMGZi?=
 =?utf-8?B?Q2ZIZmFFaWRxNUZ5amUwTVNJVUZYV3k5c0lMbFhEeGFDdTcrUnBXNjV1dUk2?=
 =?utf-8?B?T3JpN040RTlRdkNJalFnQmUzaUdwWWNERi80ZEJFQUpwZ3BQcnU5Q2JlMnVr?=
 =?utf-8?B?VlNMTmZ0NTNQWTFjMFlWZFJqVVp5b1NsblJ4ZTI0b29PNVdjcUduWTR6bGxR?=
 =?utf-8?B?THo5Nkp0V0JGMnFZMHVhVWlSeFljUEtRUjkwQzFwck5XdkYrWk90clR1U2NM?=
 =?utf-8?B?cWRCalpDRjZqc1BtU2FPNkFpM1R1S1NXSEgwWUtwRHpPVjF1ZmE3Vi94eEUr?=
 =?utf-8?B?cTFuUkRKT1h6Wm9TZk9zSjdCaWlId2NJUG8rZ3lMNnFRY2ZMZ2M3aG83djgv?=
 =?utf-8?B?T1BueHdqOHp5K3MyUWppbDNmS3JNUmtPZG0xNzZRTWRkaXJWQWtpOWJsL0xx?=
 =?utf-8?B?TzN2OXhPcUg1Q1F3blZvams5bmM3OE9qM1lRUU1kRW5VR2lUVXRuUVFPSytK?=
 =?utf-8?B?RzZ4Q2FrQzdWc1oyNk0zOFZZS1RQNTUrU3RCSENFYS9MbXVWWDMwS2VWU0gr?=
 =?utf-8?B?OEhHb3hKdGN2YmV3SHNiK0VnQndVVFlIeERPRzZwbGJYYzBCTStVVDNGbEdn?=
 =?utf-8?B?VytWREZJSzAvVVk4QUxLNjVEd2ZLNTY5N3dnUjhjNEoyNExvNnpYaFFNUnJG?=
 =?utf-8?B?YUxsUm5CR2lxdnFZT3dweFQvVUNlbUN2d3BkZGk2WmRCb085Q2hoeExjN1o3?=
 =?utf-8?B?ZW56L2g3ZmxWQzNFbWt4UVdHcnlFaERlNDZ1RXZZeDFKYnVkZ2JMZGhMQ1li?=
 =?utf-8?B?TFZhMkE0MXc2V1hOUkhGN0lxU0hOMDJHN2YvNWd3Zlo3b2xFdkFaNXdxd2JK?=
 =?utf-8?B?aCtjQXo3WWd1ZjJJdUl5dmlSd3p0SkoxZjBSRmdtclJLcVU5STVidkRHTC9Z?=
 =?utf-8?B?TURtQzZ3cm1maXZuaGM1VG5CS2xPYkNIaWw5eGhpa1prc3JZVzFVa1dBbGVy?=
 =?utf-8?B?SU1mRmVWRzl2VE1QVkdhVVNPMmFRNFJSR0xuSFd4YlBWZDc3M2pDdXhleUhi?=
 =?utf-8?B?d3ZFaUpBa0ZFcUlkRGtlZUxtdG00NE9mbldlZHFQVHRLeVNHRjIwYmZ1d24z?=
 =?utf-8?B?cUIzRWl0ZCtZa2t3OXRHOWJKLzV0Nk10TFZUdlFhRTRJL1Y1WFE5T0lWRXFY?=
 =?utf-8?B?cVBuYThudVlVSnd1Vkt4a3U3KzZ3NnFGYnkzRFFocUs0SXp5Z2RrcnlnWDNo?=
 =?utf-8?Q?T57cam0LW0Y=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB1421;6:OlPRDPtfwOo/J7r3/wk42oUj7uP1uWeDU1S599PzvbUI7fu9yN9ulVO1xLb6BTPOTNwrDajd4HPPy8gWqswHhojhg+Vh4+t/8ANe4a3lbSNh/jMuOmCYFT/ibqO24quP19PnSVDugUwKGcgpMLpsFzfSnFAqAHCekwTbwM5DQMAnmHuoACr7nQqCyIXucTBOSQKpOJEilja45y+WFYgyCO/pihJWIB8OO0IdIrGLDCAK/vOvgK/jFgkqa4IAj1MLpZhSAZQFLa9NNuIyu5bDpDTYcZLRVxWYsriTbMlGvt92xY9bSCpB/ioYdg0+Ke4tqQqBvAKuwLNcpVMhX3l1tfS8kUxaY9Fkd/qN2BMFTss=;5:3yspAs6Hx0PfUmxzdDWno2pC2hjG5AcDtftOzSTaw6OTtBFXhusFMSviCrnbN1UsdygpeqnrSRErP8H70WTmgyYtWBYkjokvAOGkqrgKsbxIULPcR5AXMykjrCP1Q5eIohmLIR5O1q7qwl7rFFnmtXe8dRBATNBH/LiVPT1iDgk=;24:ZZCsZ9Q7bPRT4Xo/4zpe1TOrA2rOCvuGmhFlA8z8aoJkEM/rthkSu8PhAj1DeZZLDmiG/lVanzoE5XVkW59hk9f5E45fBJao7qHcSKnBbMQ=;7:ahiWggx9ItX7P1AqTZeb9GaO4/zEhRTPovVVnVjoMc25lLjVg+tqiP1F8CFbpUOzYl1xuPzwwNtsjN6JVDbn6pf5cfx8a/ys+AroFEXBBJ8Lyam1+oFUVLKO7bPDP7ftubK3wh/v9mVPn2ZGEX6dsmxKI3cBllt3Xjj4Rm1nVU+CBt+X/+4EU30GXEGBjLhMKcZ/9TJbZ12pusHGdeHrbE/xp/TTNHXXQ4hUuGc2M8T6rEFYr1DqTIpZ4SXnKmZw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2018 18:55:44.3516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bac093-288e-4ed2-7197-08d57edcdf33
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB1421
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-02-24 at 16:02 +0800, Anson Huang wrote:
> This patch adds i.MX7 thermal sensor support, most
> of the i.MX7 thermal sensor functions are same with
> i.MX6 except the registers offset/layout, so we move
> those registers offset/layout definitions to soc data
> structure.
> 
> i.MX7 uses single calibration data @25C, the calibration
> data is located at OCOTP offset 0x4F0, bit[17:9], the
> formula is as below:
> 
> Tmeas = (Nmeas - n1) + 25; n1 is the fuse value for 25C.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Signed-off-by: Bai Ping <ping.bai@nxp.com>

On imx7d (also 6sx and 6ul) OCOTP read will hang silently if the ocotp
clk is not enabled. For example this can happen if imx_thermal is built
as a module or probes after unused clocks are disabled.

This driver has support for reading ocotp values through the ocotp
nvmem driver (which handles clks properly). Since imx7d is a new
compatible string for upstream maybe you could just make new-style
bindings mandatory and drop the changes to imx_init_from_tempmon_data?

See commit 2067b757e972 ("ARM: dts: imx6ul: Add imx6ul-tempmon")

--
Regards,
Leonard
