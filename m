Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeBHJc1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 04:32:27 -0500
Received: from mail-db5eur01on0128.outbound.protection.outlook.com ([104.47.2.128]:4848
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751094AbeBHJcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 04:32:21 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH] powerpc/fsl/dts: fix the i2c-mux compatible for t104xqds
To: linux-kernel@vger.kernel.org, Scott Wood <oss@buserror.net>,
        Kumar Gala <galak@kernel.crashing.org>,
        Prabhakar Kushwaha <prabhakar@freescale.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20170803125934.14960-1-peda@axentia.se>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <da15288b-f656-8126-7bc9-eb2fd58adccb@axentia.se>
Date: Thu, 8 Feb 2018 10:32:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20170803125934.14960-1-peda@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR1001CA0019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::29) To VI1PR0202MB2784.eurprd02.prod.outlook.com
 (2603:10a6:800:db::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ff6ce25-2ef3-4e7d-0be9-08d56ed6d819
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603307)(7153060)(7193020);SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;3:vruU6loNkGPbDVIPoMkikY4zxTlsHlfQW6R9FLtjBZeoqJXf7Xc51f2N3FLpnD6cU/q8N+ENBJsLfXSTyGk/GI+tY6+ImwN2z4Vl6ic6Ntd5lDnpDglqYKHVIBYHjM2auB9lAw1VU6fVH1wZlJicIA+zprtYP/OOjeuWtSvZ6iSwZK2WpQLJ798lSw05vNdpVisJbsCpVXDxzO0rtewsk41US2dI5RuH2111ypUnoAdpDcY1D2gWOhrfW9zwg5Vu;25:xGt9EqS42jg5uxnELLl1LfSoNoQQdbTcs/Lrd6/ry5aYKz7RVvjqKmWdmMygX07s+/CDE5eaN6tSQr3d+gk9Yb+eJMRc3/4sDFKCSaX7sxZnl0fpNuv4rrjTHLkh6QDdaEfuwJA4I4Gn4IPont755T5s+s6vykWOS1zm15NS3sPLdQvD20Qlyk+BDKG862wyzZ2GFzB3vb6iL+wB8ZbShlszILct6+gVsKud6QRyE9JKMYfwyg5HzlC5tabm0ltGcuahp2HRN/3czDuTTcZQYs2AFV4RoULdwM7PoOXuL1v6TJbZbNOGxTnmibxxfLMqKOPF3S24jPmnjVsrBYIUVg==;31:X79GQ6WxKZgnaLHgDpJiAqSNyAmReE6mBEkrGkL2k9y4vbzLTOwmIGA6RRiHesLmY4Eg27S14gwmzgX29tQPv52GC30Bqk+Ti0Sl9upXNX6Hmy2GkhuwT+UUUgDEWZFdjbnW9PBKYdf2NSt5UXZgcifnz2cCrNdQKC924hguGAa548nn+SwiAZcpCaWUH3BuSl2bWvzldlqhHxjTTUGOwXifbtKiwl4hkkE/vL9GHnw=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2784ECAB270C3DEE3E64FAE4BCF30@VI1PR0202MB2784.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(10201501046)(3002001)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;4:Lnwx6TpDSC1uiEvI4HXXSO4Nzb/AQVIO+0oqrdTrIqdcjPvm3SlIwabw3PqKIAi5ZRwfShFXafsMyumJITgiQmIbhsdu7j4PfbUwrnukRr0lNiV8kQvsy1XRXdx6CnwKwXhgZUyMJS+27I+NN3Jx1M3LAyVxuFf2/VoCQsgXWgwcvfS8m2g7z2GXjGx9IMQ7+4vhrPDtjFWEc9PEpuGMBvENl+9IAfz2RrSODDyzMlchm4PKoW6b7oI1lx8qpyUhxy+AQYGtMgKRnNWe/QMphg==
X-Forefront-PRVS: 0577AD41D6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(39380400002)(396003)(366004)(376002)(346002)(377424004)(189003)(199004)(53936002)(23676004)(2486003)(7736002)(105586002)(8666007)(36916002)(81156014)(6666003)(106356001)(6246003)(7416002)(81166006)(229853002)(97736004)(8676002)(65826007)(186003)(3846002)(6116002)(31686004)(64126003)(2950100002)(74482002)(50466002)(5660300001)(76176011)(59450400001)(66066001)(4326008)(53546011)(31696002)(36756003)(305945005)(83506002)(386003)(86362001)(16526019)(2906002)(65806001)(47776003)(65956001)(478600001)(26005)(68736007)(16576012)(25786009)(54906003)(77096007)(316002)(3260700006)(6486002)(110136005)(8936002)(230700001)(52116002)(58126008)(52146003)(117156002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2784;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDJNQjI3ODQ7MjM6Q0VnSWJrT3JrTVk0LytPeUpnckl5RThs?=
 =?utf-8?B?UHVvcHpINkEzV1NUNnE3RDl3TEZaNFBSMUd0SXl2M3FMVTE0Z2VQeW82Z0Zm?=
 =?utf-8?B?ZjV5ZEJ3Q3ZmOCtqdVJESWxkZjV0czNxMEdaMXp5R2xraWxXcmpPazNUaklX?=
 =?utf-8?B?TlVvdkNaZ3N1RjFvOXFqUVJxZzIweUpNc2Z1WHA4UHR5Nll0OU5aU0FKdi9s?=
 =?utf-8?B?QXp1c1RIYjc2dklWdzcyU0VDL3dmV3duRzhGd09PcHV0YlBlbkFDMHU3VjFE?=
 =?utf-8?B?RVFiWTRzYzdVMkdkSFF4MmdrQjRmajdUTSs4dEFEcUFNUlowSzN3TllMK2or?=
 =?utf-8?B?M3RVQVlDMkRMbCtxVmNwNHFGN2pza1JlQ01IeFR4VEM3NEh3WkYyb0Q4bEh5?=
 =?utf-8?B?UFFtTEpKVmt4Sk9iUzNta1V0RmFCcTJuZk51QmZzK3JLNjJCYW5HdW5PU3Vs?=
 =?utf-8?B?MGc4OGl0eFN4ZTc5VGRiYXdOQ05xMEF2MHNsd0dwTUJFWDFnK2FoNlFGTWNP?=
 =?utf-8?B?RFZtWUJpY0tveGgxaHVyQlhBVFBOem1Zcmh5QVQ3YkFjcXNHNERaWktNakZU?=
 =?utf-8?B?S2dhS2dMeERTa1g1MnVxdVlCSXA5a0dYODBIWGpBS3k1dzV1MFJkR2h1bnA4?=
 =?utf-8?B?UkR4WWpYNVhKUE0ydUV6b3V3REsvbzZ2TjdxNDRDNk5CaDdJRk5mMHN6Tk1O?=
 =?utf-8?B?bjZaR081bzNETmtTN3RodkZkUHA1Nk1RVDVyOEY2UG00NU1xVEdGQkt4V1hC?=
 =?utf-8?B?UVJrT0RDMnJ4bXJleFpEYncyVDZOUmN6OHQvMGpnYlA5NFpLcFNPMitHMjUx?=
 =?utf-8?B?c2RkU2hSUGRYR1pKblFIUEJEQ0htcVdqVkhzS3BFNTFDQzA0elNDUzBnNjY3?=
 =?utf-8?B?SXZuY2hlRWJtTjBTRmt2NFdudnNSdUMwMHJlT1ArK09PTEFlbE15UUFLT2VD?=
 =?utf-8?B?M3c5aTJKSCtXSlROeEpHZTlpNFh2RXdxNSt1d0VXcnl6YUlvSTVZclpJaVhn?=
 =?utf-8?B?RVc2b2VhdEFPSjFqaGQ2SzlWaEFIemIzRGM5RWFWSjdJbkg0U25oU2YzQkhl?=
 =?utf-8?B?c05TMm5wbUZHbTV2N0JFK0h5SW1aTFYrQllYYVNPOHpFL1o4K0ZlWE4zd3o5?=
 =?utf-8?B?Z1lTazR0bEdlU0w3eFd5WHNOaE5GVGcvei9HMnA1em1FTTVYWG41bFZOcEQw?=
 =?utf-8?B?VU1zRjJMQkdlc3hTM1kxanA2UlRFK29TV1l0L0puSGVFUUFXaVlXekh2ZTRy?=
 =?utf-8?B?N2t2WXdhT0VHanVoQnBoUHpFRk9mTFl6M25DZ0tpSkxQUnNlZ2l1cEFaUGkx?=
 =?utf-8?B?VXp3NEJodzRtT04rb2ErbFFVQmRyakxGUW83Yk5GSll1REpnTSt6WmdMOXZC?=
 =?utf-8?B?UldyOTFMTmRkS0dTU1dMdFZkN0Z3SEhPcjEzYzltNlBhNXJ5eVBPRWJMOEEz?=
 =?utf-8?B?dGJNZnl4aWNmaXBZeWRuSTZRTmdsK0ViSTZrZnc4Lzk1V01vWTFwR1V2UGZv?=
 =?utf-8?B?RWFBV09KRHJtRWVQc2ZuYndlOTY2V2dIMlhIeUxoQkNsWHhMYWZ5L1l4YzhL?=
 =?utf-8?B?TURhWldlVzB5bzJwcGl5OTB3NVhncUM4US90bkNoWkJBcFArT01qSHQ5dEtN?=
 =?utf-8?B?KzRoODl0N29FMWcwaDdVVGJKSzJtQU15Um42VjVRVFNsbVBHaUlQU2txelMz?=
 =?utf-8?B?M3NrL05QN1VRTnBFRkJvc2hxWGZheWFJVVBGNFVKNDB2bFBibldNRXVSd1lK?=
 =?utf-8?B?VXRSdjJSdnhGM01Ja0RFb0ZQK0VDQ3VYVys1ZVhNZHg4Q3NJQzQvK1B2dFhh?=
 =?utf-8?B?Y1JOVEFNamdRbm9NRndmbm5JTlY0VHlDcGsxNnhTMDlhMXlsVWtiR3Zjb0U1?=
 =?utf-8?B?b2NtY0Z2YjZuWWJlNGdZN0RPL0d2NHc4dW53cHhHNTJiL1JXUG04WFN5Rzgr?=
 =?utf-8?B?UGg0MlltRzN4UVBzZjRnbDJKK2NFWVdzY3REcEN6L3JYTkd5WFpHeWFGSkNa?=
 =?utf-8?B?cE1DakMzMk9DNUpEc0NnbXk1UXl2RVN6SGk2SnNkTklzR2I1ZlBXbEhWNzJ4?=
 =?utf-8?B?S3FYMHJ1TGlJdy9naC9kcHpUMDNUREF2N1B2UmdkTFNhaXNkMjhPOXRMZTBI?=
 =?utf-8?Q?VmbOh/W0ZwsfputS77JmN6XYo=3D?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;6:yixBoiOce6pes5vbAlTjF1IImV37CfOdA9vS2xb9/HutwMPFNWczQvF1jHlBg0IdNacd1m1i+avarf2i9VA1skgf/UpNWRGrNQqSezFG4gAOHjzxuX28kHxnRMwGY29oQZhBXN62Ysqk/zm2jCWynCz3YjT1oV0CaS94KGa+nijPIqdtJxkgJ+D/sqepXfMlTfgvTu7ROgHpMuGBOMyYdYXeude0x0SE6Oi4e6fFACMfPw2NY6OSrlajAcsSFk/EsS+tfe6a5gJRANQunE3x/LEZT4xBfWtyU7meawezazQM96PHx0NJBjmRbnL0vpk54pP7voAYRV5vQrFfj5KlXCHCZK2wgf6eT0rTNMMJeB0=;5:SLIxXjsKYnvpFFkFQ10okycVNfxRlgN762i7isRK+A3aSJIwlNZDwdvi30YsB4QpbZwyb1QPJy0iZCb+XRFq7Wv3jY5xYMq9H/dNQGU3SoOTPgh/0MwqxjEWeBT0CcFhwfuNMPaFH7aY7Q5X8l4fcXBqjuuZURZLgmtPr5F5W+o=;24:twMMGL/RhKk4JpmnPZlwhmXeT01/v4fwZGKSRHPAYcksWSFqZtPpLYeFd4NpOEYeJidoyoY1KHa9QvGx+fc9c56oCrJhbS9yTLctkDYujho=;7:WQiiuaOeBp0Qa5Akln8mbH4YM7yp1rO2pHkILnnw/ihsaA3X3gIHBXW0747KdFUB1MKXVpNHUIvtEmwNeqyO/kofQAbJDIGZAakbqE+mh7+CrX3TUvz5PwRV6JXzUsuqTIzNndmUYTqrv8+I0MwNxW2I5Bml4WkS1aqELK5cJRjt3Nn/0yueU71HP1Ki4ZPqImgCAZzRBo4YLQrRlQ7lWKzg2x3FgBR0mE04lOTEORSfELsECe3zU4y6Y3qMcsLW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2018 09:32:16.1151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff6ce25-2ef3-4e7d-0be9-08d56ed6d819
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2784
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Adding some people whom seem relevant but did not get fingered by
get_maintainer.pl]

On 2017-08-03 14:59, Peter Rosin wrote:
> The sanctioned compatible is "nxp,pca9547".
Ping.

Cheers,
Peter

> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  arch/powerpc/boot/dts/fsl/t104xqds.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/t104xqds.dtsi b/arch/powerpc/boot/dts/fsl/t104xqds.dtsi
> index 2fd4cbe7098f..615479732252 100644
> --- a/arch/powerpc/boot/dts/fsl/t104xqds.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/t104xqds.dtsi
> @@ -269,7 +269,7 @@
>  
>  		i2c@118000 {
>  			pca9547@77 {
> -				compatible = "philips,pca9547";
> +				compatible = "nxp,pca9547";
>  				reg = <0x77>;
>  			};
>  			rtc@68 {
> 
