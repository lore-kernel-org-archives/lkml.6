Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AG47ELsSohpPnShP9GjJ6ZNBTyvvUNF1vaeDqKhUS3c966VaACZq51jceclcl2UR33dyd6bbZTqO
ARC-Seal: i=1; a=rsa-sha256; t=1521809280; cv=none;
        d=google.com; s=arc-20160816;
        b=t6yf7gPi/MQD9OAFwttaAsPdrsEl3wEwljct3j2hVuo7DSu21GLS2ABc4YuQXkYBSG
         HOKmVaQLtU2ZEMw0/pBOsJt+x6+wTg6xtzRZmJvUB3TKuHfkogMUD1IHpn0VncA1ZajD
         oiZUyc/SnyoFiELjsti8pS5riEO5/kyKdj9eK27Vn36Rb4I68Ml/i6jPkTJFfYvG7huV
         P/7yw0P9ZtIcFZkvQVBjJuTUmjjFdxfBxYXV0JwSt/Hso/X6UyA0/MTXn3e8CAkBHldx
         aEfjS2YMCUIroEVPzlm07B1/xvCcMFdCr3ncv+TYEDH3K9/T5RFLT9B2NhLJDlINp3cy
         EpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=Uj1/mkGrZ2tCNgk4rELeh5E9gC7Mzml8i7cFAbJJiOY=;
        b=KEgVh3xnauwKq/EBnCpC9jy2Fz2uNIsLNGtRbtn/M9jehsn875JX6VDtYywZDmGORn
         h6QR5f/o4p0j6wq8+Vxlo7y9LN2N0dlch3NcpvFhhwyImcikfBcnu+XHdpn+vEceoJtb
         /P6xuNeZcCzcXe3bQu//puZd9hnD0ZPR+laFeO2jtokoVAqnvJZdmE9RsYltU6Ogo1dq
         cl7IHmYmXzyYZcAOulSKYxsNfxgi6hOQ199nXVZTjXnOsnekLln/+zD5zdSZlQ9UqsJ5
         7EmG/q7QYkI3zvVrOuSa4ZlSTdzbnbgUtbZDxDOMVVVVuVXYlZQ/ky2nMtKMuKaebt0p
         09Sw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=V1QxTJ9B;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.1.90 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=V1QxTJ9B;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.1.90 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v3 05/11] dt-bindings: i3c: Document core bindings
To: Boris Brezillon <boris.brezillon@bootlin.com>,
 Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>
Cc: Przemyslaw Sroka <psroka@cadence.com>,
 Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>,
 Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>,
 Alicja Jurasik-Urbaniak <alicja@cadence.com>,
 Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>,
 Rafal Ciepiela <rafalc@cadence.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vitor Soares <Vitor.Soares@synopsys.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Linus Walleij <linus.walleij@linaro.org>, Xiang Lin
 <Xiang.Lin@synaptics.com>, linux-gpio@vger.kernel.org,
 Boris Brezillon <boris.brezillon@free-electrons.com>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
 <20180323110020.19080-6-boris.brezillon@bootlin.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <beba0248-1a41-e39a-75fb-a1aa94337008@axentia.se>
Date: Fri, 23 Mar 2018 13:47:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323110020.19080-6-boris.brezillon@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR07CA0198.eurprd07.prod.outlook.com
 (2603:10a6:6:42::28) To AM4PR0202MB2770.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbf7829f-7c9b-4c24-c0db-08d590bc4c02
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;3:em5ojp3ugITXl+mB+++F7b8nbk/r36C0xFN8prqAFBAVh6eJBlDh4vwdVA8kiqT34S/DzdSXbeusikR9UD03KEEu58L6f+KUunL4ep2RT2nFB2siLO0F5qw1MkKCJqKjEVkFQqvZHJSGFrRMm9O9PcaGyvL9W3fbwDTbUsTw6q4uZUTK3Ex+bH8Gi/Xe2WUYLrW/xqLmqJGOmUlcI5NdEEGVqxhvivdU/LA989H3nC2uLejBvRUSdQSUDIo7JyiH;25:0P6y2IrSuDOXPWABpZ0RGtCsMb9s+hjEO3/COhEWHxJwn+yut8XiJ4KJqoMsEfmxz/yYhG6mjEf1cUl+5Fsys6Uzg6UNWwQ5fKS5qZwSHd3JdBY6yBVbaNoiZnfr2bcOLbpdmC9xDY/fVosCimxAnxyklC8Bp6+Ab+7sSgDPRIN8FwT4RtrlwvlHAzKYZFGdZoe6k4BXadPSiztg/cBXNNSTtl5WZ+4DSWL6roCSa83VfWjIvDw/7BGd9kumXFbbBEpFyjkPKZVfEPKLTr6/v1L45gnradOh6QyyUhxeFJNgUTGLk6+Uy/W5dRXVK/1WCWeUjBoIEe531guD5xNYjg==;31:NCt1Gf4MVo6K+A74O3pjGOC1dIk1aQeb1qP8AWA61sAIylkV3x4TBWDWD3XMwEq9o6LNmyb1wOKeaLmAtH3RajLzYAqYvqFKEXwHM6noQZOt2SdVvxK2ebrMyr066aY/nE9YOSomqazQUryesnvSy873E6ztbhT45MOZuNkZ74ayWBleIn/n1yEx3KY/URMK1Za978Ot0fydR5h3IVdAK4C7SiciCX1MqHxorqOo3LE=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2770:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2770A409E01AFCF284285F69BCA80@AM4PR0202MB2770.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(58145275503218);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2770;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;4:fazvjewGwH+I093qlvlMAw3PF3MkrQiubvByc6my8IiPpJNI1TGecAEpOpICet28TURNB9QRfPNr1+aaFHYjgNoA0lg1s0uc/qAd1c13cdrMQLV0qbtGaHeGucLE40TkmqBgoJs6g6F1rPMTI+OwIReddpjSxa4181BvtzAg7UT2t26A9qT5DWYHHJ1wUmMPLah4/5OlfSVTEOOX79nrRdTOR1n2X7/T8tAmkbm5aLoT2D6QpaUYcnmYbJSMjzjnjhKPLfPx5SusEA/bbS1NM4O+8DSJAmnPQUH8WhiI4GHgEp9VXXXdzU+/86mdGXSO
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39380400002)(376002)(396003)(39830400003)(366004)(199004)(189003)(377424004)(5660300001)(7416002)(7406005)(11346002)(65826007)(6116002)(3846002)(8666007)(97736004)(106356001)(6486002)(53936002)(6246003)(478600001)(16576012)(316002)(229853002)(3260700006)(25786009)(230700001)(446003)(6666003)(7736002)(305945005)(2906002)(74482002)(65956001)(86362001)(65806001)(575784001)(66066001)(47776003)(110136005)(76176011)(52116002)(23676004)(36916002)(2486003)(52146003)(386003)(53546011)(31696002)(4326008)(5890100001)(186003)(16526019)(26005)(36756003)(117156002)(58126008)(77096007)(31686004)(8676002)(64126003)(68736007)(50466002)(54906003)(105586002)(8936002)(81156014)(81166006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2770;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3NzA7MjM6eUVyRC9LWjFwaTdvYVExYlVOSEJHVWF5?=
 =?utf-8?B?VFUyMGk0b0pzd3U5TnE2YnVJSG9WMjdMeFRCRUdVQ3A3UC9RSnVqNisxS0Q1?=
 =?utf-8?B?TVFJS1REOUE4cWxxQ1FpL05reS9LZ2o0MDN3WjRYcGwxN1hXZ3k5MlhhQzl1?=
 =?utf-8?B?UlRUL2VXQXpTTFNOYWd3VUNNK3NwT0orK0wwNlpLTmZhTUZ6Vk9WWDQyaXBS?=
 =?utf-8?B?L3Z3UFlZd29XdFFuZkRtVTFFRm9GcDM0VTc3bThRUU5uSHhMaDh6akw4WGRv?=
 =?utf-8?B?c3h5U3IyUXZBQWY4YjlFdjJiYlFpM3g1NjNNWTF0WE11eHc3ZnRwcWtpK1ls?=
 =?utf-8?B?cjZ3ZkJkaHZDZVI3S1VxRjA4WHNMM1pSRXptVXNUcW82SVZsVG5OWWt1Qk41?=
 =?utf-8?B?ZCsrL3F2aFdOVHN6TTdwdFQzU0NnNHBhR1MzSnpyV3gwV1JxaGxYMElxRFN1?=
 =?utf-8?B?ZmlLbCtoL0Fnb2hLTXNoTzkwZEpqbE1oWjh5QzFzczlEbGx5QlZ5bjdkRUI1?=
 =?utf-8?B?emxXT09sVk1RZUp5bWZuVmZYekMyWFUycEhrdTZoSThDL3FJbVlhdWRma2Zy?=
 =?utf-8?B?STNSYkJROUYyV24zc2VERTFzcXYrQ2JYU0ViemU4M0tCVElpMXM0OW5zUVBj?=
 =?utf-8?B?NHZ5ek1kdTNiV05pUkpDb2FORFM2VHRsNzdsTkJzL0dYZFlTN0QwTTQ3WTVN?=
 =?utf-8?B?YmppTitjbW41VGQwUU9uRnF2c1pKRzhWaFN3OUVlQU9aaTZPOXIvV2M0bHBS?=
 =?utf-8?B?Wm96WlByK3gwQk5mcGlPNUdjSWg4aHJhYzJJRmV1M2o0MnIzdjg3MnBHY3NL?=
 =?utf-8?B?VlEyRkFiTHIydFBjT0N3MzBBMENkdU1LaHhyUndVQ3JNNXJoMmpVaEhFNWRI?=
 =?utf-8?B?bHpVRFlnNXJ4MmdJd0JHSlhEdEJiRU9UZ2hNNS93SUtvV1JVVlJqUHJUZTFu?=
 =?utf-8?B?UHQra01vcThIL0t1VjNFQWlnZ3k4REV1TGhqYUVlMUN5dy9ZVjVQVUdlSkhO?=
 =?utf-8?B?V1duc2pxR3NYUld0TFdVekZoU2ZaZ05aOFpkaHpwZE1EeEx2YzJiVzE1TSsz?=
 =?utf-8?B?UGJnelJuUks5MEUxa3N2TXE5QlIxbjFnejFLcG9LYW9mWmoyQkNzVEhWUFFY?=
 =?utf-8?B?dksxVTVTWG8weVZBU2IrN2tnRkZsVjVReUVGVVlZY1VVOWNQSWhZZE5FRGNP?=
 =?utf-8?B?MHRqNktTK2ordlRXWE9OSDR0Um1ocURZc0k0bkhOblVLV2tlNURvd1FjKy9Z?=
 =?utf-8?B?cEp5TzYvN1pLSEtrYjZ0L0RVRUFoTWxZNDl6aUs0N0tERlZXUW9NQStTV0Vi?=
 =?utf-8?B?TFRPc0lXL0JwRGNScThqMER6SzhuTzc4MGE1YWNUbHRhSG9acWRha09IZHdQ?=
 =?utf-8?B?L3J2SjlramZWOC9iUkk2V28zczNSWlcydG13ZFBBTXc2MXRtZkJhN0l3dy9y?=
 =?utf-8?B?UWZhMlBCeU0ydkRhSGY3RDgzV25rSW9wcnRsUjllZzYxejVMMWhFVGFac3kz?=
 =?utf-8?B?RmpmVzg2aG5wRjlZYWtiN0w0a1JkeURBaEx6dVIxRERwTDM1emtxTUU0UHh5?=
 =?utf-8?B?Yzd5R2tnUEdmWGFET2taZUNIR2FOSGFUR0dFUHJLTEk2aXA4WStZT2ZOaWlw?=
 =?utf-8?B?VmFoeWhpZi9oa0xPU1BPK3Z2akhVaGllckdYRUtidm9RNUpvdkhBd2NMV3Ey?=
 =?utf-8?B?WUd3TW9LdU5QQllvVGxkWkdOcEdZWVh4by9HU2ZSMmk1SUdaSmZnd3JBcHJL?=
 =?utf-8?B?NHRIOFIySmxkUUI4clhUTDhCcy9TWmdFWldlcHMzUVpUbUc1ZXArc1NRTlFh?=
 =?utf-8?B?STkxMVRyZnNuc3krYkVxcTRtbm5jTE1zUkp1anJzSkFxV21KOWlWb3hySm5l?=
 =?utf-8?B?TXg1QnhUVGttMVVLMncyUXFBT0dYUmFTM1grZ3VGdWUrSHBpdnUvL1c3SXJF?=
 =?utf-8?B?b2xoakFDRVZZZTFtck5qVEVnNmc4QXVOdEJDcXQvSUZpbENkSHFpeG9MWTNS?=
 =?utf-8?B?T2cxNmV3UVB1VkY2Q2JCTnRndzJIUnZzUjJQSUlhQ0NNR3Z0MVJHQ1c4Um9v?=
 =?utf-8?B?d0UyaHZVYUp4a3g2YWhYR2g4MGhxRk5BaG5TZWNqVTZ3VDczVExzdWRsbjRp?=
 =?utf-8?B?QW1LSWdFVnRNNWFPMk5kcDBuQWYrWXFaTytsWi9BcnRJSnkzSVNaQTVLeHpa?=
 =?utf-8?B?YlRYV3pMc0VXKy9LM3VLQzZVbVYzUGc9PQ==?=
X-Microsoft-Antispam-Message-Info: 3UxFT4UPHoX5OHP+KeLgBAj9olypwfUwmMwN3jJaAeTwjnVERInmEclFwi3gfJPwA/aHX3CJlq8fvnqXNVy/JZRJNFDu5IYMx98gIwmAJOmwVE1psra2Ot2e4WcLMqQ/2ONYbc8Bf5NvWDFrMLD6NacbQ091liCvpgS9hmbEelBtpK4hoXfucaZriwi+IGMe
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;6:a+ER5A1HYdYnj/VMVB2SCYgnQk3CGrwf/DNuxO4OpEAe7NFMdlWj98YCfVqT3JN/qGlbYGW2shho0CH/A8J5QFOsmD2YHHX7DnKbM4NI3OOw8i0aKI2dT2youDDTq414xheOdbQ9U++WRMzgtx8jdYWqxaaZNf50Cyyv1j5//w49bez1gXGPHdVA9saiyjVg7JWbfCscUWNFzYK55BP7HAwUViz3SUv5zG0f2LNbu7mqy+kptciCvd3DPd61nJXoPr7n592zMcJJ88DCpiYI320XeDUoljoBe79F3kO/ZDyl9bGTMpRsUT6gTOAR9Wf7CBKryjfBo2EqxCHW7m7A7ee1yL6otwGYrjmbZvXRbGM0W1dxfIVwSRi84W4L80hybsciep1dI57Fewzdl4Aj040g02+Upx3iVxnTrfBxEuPHbXDnOgl1cTXOCImsngoYNdaozZYOzIOtFZITfZQ3Rg==;5:grq0CXE3qHHxrfwxlTVn4jZqbL2HXExChpqb5ipjEnr4b6yNjHh49ESBKGlS4kz3MYB4DK6dPtg2+jmY5Ej9FEFxqbsUx0/EbjtNwA9O+kKmJntNphvP9MSAw07E0XjYPXwzNnSE/3S2TpPns6W1y4JJJtNbI7NyvPha0SEw0Zg=;24:S7DvoKRtrXL3/mXmIlO7FC3cZuJeC5DzKeN89x9jer3MxFsuGJIMTF3PnkaTyu9X4F3kPCNx5m82//17jaC1V2z+qBQtLC3NlcRkBEcZ39c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;7:/iN/cDrNRf3Np9yrPL28RL+BuRiIKh7EZDnRKPWBY56eVqprWgjaQi8MgqVmVjTN7WorQrakHQShoK5G+a9m9fg5uXOAG8L5GVlk4vGoZiME/UYWiHbbuDva1eLubQhZP1fwx5xbC7V8e9D0RAF6mVpraeTnNQTHtIbK3PaPNH4P/eZmP3k4VHzSEA2cUIPRPQPbbl5fH5af1JWbKO5ylbIQiov6XtRbJMWs/RdAHjwSA1r0OBipEcULC8g2Vv9I
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 12:47:52.4545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf7829f-7c9b-4c24-c0db-08d590bc4c02
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2770
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595725932611927845?=
X-GMAIL-MSGID: =?utf-8?q?1595732688652106293?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-23 12:00, Boris Brezillon wrote:
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> A new I3C subsystem has been added and a generic description has been
> created to represent the I3C bus and the devices connected on it.
> 
> Document this generic representation.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
> Changes in v3:
> - Rename {i2c,i3c}-scl-frequency DT prop into {i2c,i3c}-scl-hz
> - Rework the way we expose the provisional ID and LVR information
> - Rename dynamic-address into assigned-address
> - Enforce the I3C master node name
> 
> Changes in v2:
> - Define how to describe I3C devices in the DT and when it should be
>   used. Note that the parsing of I3C devices is not yet implemented in
>   the framework. Will be added when someone really needs it.
> ---
>  Documentation/devicetree/bindings/i3c/i3c.txt | 140 ++++++++++++++++++++++++++
>  1 file changed, 140 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i3c/i3c.txt
> 
> diff --git a/Documentation/devicetree/bindings/i3c/i3c.txt b/Documentation/devicetree/bindings/i3c/i3c.txt
> new file mode 100644
> index 000000000000..ed858228d26b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i3c/i3c.txt
> @@ -0,0 +1,140 @@
> +Generic device tree bindings for I3C busses
> +===========================================
> +
> +This document describes generic bindings that should be used to describe I3C
> +busses in a device tree.
> +
> +Required properties
> +-------------------
> +
> +- #address-cells  - should be <3>. Read more about addresses below.
> +- #size-cells     - should be <0>.
> +- compatible      - name of the I3C master controller driving the I3C bus
> +
> +For other required properties e.g. to describe register sets,
> +clocks, etc. check the binding documentation of the specific driver.
> +The node describing an I3C bus should be named i3c-master.
> +
> +Optional properties
> +-------------------
> +
> +These properties may not be supported by all I3C master drivers. Each I3C
> +master bindings should specify which of them are supported.
> +
> +- i3c-scl-hz: frequency of the SCL signal used for I3C transfers.
> +	      When undefined the core sets it to 12.5MHz.
> +
> +- i2c-scl-hz: frequency of the SCL signal used for I2C transfers.
> +	      When undefined, the core looks at LVR (Legacy Virtual Register)
> +	      values of I2C devices described in the device tree to determine
> +	      the maximum I2C frequency.
> +
> +I2C devices
> +===========
> +
> +Each I2C device connected to the bus should be described in a subnode. All
> +properties described in Documentation/devicetree/bindings/i2c/i2c.txt are
> +valid here, but several new properties have been added.
> +
> +New constraint on existing properties:
> +--------------------------------------
> +- reg: contains 3 cells
> +  + first cell : still encoding the I2C address
> +
> +  + second cell: should have bit 31 set to 1 signify that this is an I2C
> +		 device. Bits 0 to 7 encode the I3C LVR (Legacy Virtual
> +		 Register):
> +
> +	bit[7:5]: I2C device index. Possible values
> +	* 0: I2C device has a 50 ns spike filter
> +	* 1: I2C device does not have a 50 ns spike filter but supports high
> +	     frequency on SCL
> +	* 2: I2C device does not have a 50 ns spike filter and is not tolerant
> +	     to high frequencies
> +	* 3-7: reserved
> +
> +	bit[4]: tell whether the device operates in FM (Fast Mode) or FM+ mode
> +	* 0: FM+ mode
> +	* 1: FM mode
> +
> +	bit[3:0]: device type
> +	* 0-15: reserved
> +
> +  + third cell: should be 0
> +
> +I3C devices
> +===========
> +
> +All I3C devices are supposed to support DAA (Dynamic Address Assignment), and
> +are thus discoverable. So, by default, I3C devices do not have to be described
> +in the device tree.
> +This being said, one might want to attach extra resources to these devices,
> +and those resources may have to be described in the device tree, which in turn
> +means we have to describe I3C devices.
> +
> +Another use case for describing an I3C device in the device tree is when this
> +I3C device has a static address and we want to assign it a specific dynamic
> +address before the DAA takes place (so that other devices on the bus can't
> +take this dynamic address).
> +
> +The I3C device should be names <device-type>@<static-address>,<i3c-pid>,
> +where device-type is describing the type of device connected on the bus
> +(gpio-controller, sensor, ...).
> +
> +Required properties
> +-------------------
> +- reg: contains 3 cells
> +  + first cell : encodes the I2C address. Should be 0 if the device does not
> +		 have one (0 is not a valid I3C address).
> +
> +  + second and third cells: should encode the ProvisionalID. The second cell
> +			    contains the manufacturer ID left-shifted by 1.
> +			    The third cell contains ORing of the part ID
> +			    left-shifted by 16, the instance ID left-shifted
> +			    by 12 and the extra information. This encoding is
> +			    following the PID definition provided by the I3C
> +			    specification.
> +
> +Optional properties
> +-------------------
> +- assigned-address: dynamic address to be assigned to this device. This
> +		    property is only valid if the I3C device has a static
> +		    address (first cell of the reg property != 0).
> +
> +
> +Example:
> +
> +	i3c-master@d040000 {
> +		compatible = "cdns,i3c-master";
> +		clocks = <&coreclock>, <&i3csysclock>;
> +		clock-names = "pclk", "sysclk";
> +		interrupts = <3 0>;
> +		reg = <0x0d040000 0x1000>;
> +		#address-cells = <3>;
> +		#size-cells = <0>;
> +
> +		status = "okay";
> +		i2c-scl-frequency = <100000>;

Another s/frequency/hz/ instance, similar to those reported by Thomas.

Cheers,
Peter

> +
> +		/* I2C device. */
> +		nunchuk: nunchuk@52 {
> +			compatible = "nintendo,nunchuk";
> +			reg = <0x52 0x80000010 0x0>;
> +		};
> +
> +		/* I3C device with a static address. */
> +		thermal_sensor: sensor@68,39200144004 {
> +			reg = <0x68 0x392 0x144004>;
> +			assigned-address = <0xa>;
> +		};
> +
> +		/*
> +		 * I3C device without a static address but requiring resources
> +		 * described in the DT.
> +		 */
> +		sensor@0,39200154004 {
> +			reg = <0x0 0x392 0x154004>;
> +			clocks = <&clock_provider 0>;
> +		};
> +	};
> +
> 
