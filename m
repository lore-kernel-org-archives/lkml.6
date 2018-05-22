Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeEVL6K (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 07:58:10 -0400
Received: from mail-sn1nam01on0068.outbound.protection.outlook.com ([104.47.32.68]:25243
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751172AbeEVL6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 07:58:05 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jan.Glauber@cavium.com;
Date: Tue, 22 May 2018 13:57:50 +0200
From: Jan Glauber <jan.glauber@caviumnetworks.com>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: George Cherian <george.cherian@cavium.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, kamlakant.patel@cavium.com,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org
Subject: Re: [PATCH 4/4] i2c: xlp9xx: Add MAINTAINERS entry
Message-ID: <20180522115750.GA9310@hc>
References: <1526454019-32714-1-git-send-email-george.cherian@cavium.com>
 <1526454019-32714-5-git-send-email-george.cherian@cavium.com>
 <20180522115414.473odncwfdpgmcz7@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522115414.473odncwfdpgmcz7@ninjato>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [88.66.107.231]
X-ClientProxiedBy: AM5PR0102CA0032.eurprd01.prod.exchangelabs.com
 (2603:10a6:206::45) To BYAPR07MB4597.namprd07.prod.outlook.com
 (2603:10b6:a02:f2::23)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4597;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4597;3:6PPnptEel07vBtNMqY7leMCTfdCk1yWcEF6YJokfDqbWr8jYoZyi62LQAz7Kjs9jdtDXpS1Yvjnuk4Hb9isHe0tLTdSEq+ynb4ySdB9iUQ2/J4Jw+F5ygqZkh8k/96+/SRRTYvIIuP9lCQpbn3dAgn1MEBBT73BWDscmv/NTNuoHOg6h4F7dvpClEpAiy0G4nqqsdsoiTmy8D64Y3jsAZiAaMKpaxnFQxlDXi5bQrU8v2QYKuiSm7GWTrI6o00Jw;25:kNXaK/nhL0CTnngDdwtt4Ple+sTITjUciqEd4uClQOz8CthsaBH0BeyqnK+ybSC0+63s6FzpAwWG8D98kjpTr1VAtXnP38RTvs9UG7f6P67vm2l7Y+ozgBwYftKShGDu4z4LfdmoS31jXM2JSkDpSDusqQU3T/ApFG94HMhehvp0WmSaoiXmnO5WUQKfVX/LNJ1kKb3g5HyTS93RjcVtDvPhVyHdWGn6PZp2diNuXzh7WdLFQDqI+evxuKqn0O6vcEQOCPK+4GZlfcMtkoDWTnc2TF53pWKxHFQMvltS6/3MS7hAvcTbmYeAz8r/KwsmfL/9duYvTjer9ph8D1OEig==;31:qfdRaHWTs/yturCXv9Uj6yJMXrGUs1qXsna74CVG5ksGh/rDIPX6KgQ4Q0E3xAjPMtrND/4ScN+hVpzteeaZCrrtXKzjEGWMKLCmGPq+RcnIC3+hNa8cRN/pzAPQbUX0nui9gPNbTnrhuFylH0X87y7EnYkUUmY0ECbIyKiZyS1F1ELfMoz0xECMwcVqxQAXDdqknVoQru0Pc6aXsY0qTEblwcJ4maduDaZyhJ04GQI=
X-MS-TrafficTypeDiagnostic: BYAPR07MB4597:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4597;20:4r2ZibTU7wavdWS5m2c2psWMhdY0yzcXKOcIN4d2ETKe++G91IVu8fvutpioPdmPGlTO0i1WyOHGZ7KdO0YtDGDh+6YxE1mmcuRbIZH+Ro7XJU5IffhVmVt5MnRD3qkFnrRK45MxUYX2U2Xb/8Dp9cRZgWbRli7QZDdJwUp1uoeymX7HqlU7exJEpqX7SjRwE1IbiMNKHPhlzMeI7hZ16+FDEkELyOYds9n4gooPjFFIHGieS0JWFzmIwlkg0alf8XqJQEdLWy2zx9IOLfneDTpF6mqbyTR+3Ws86Kwc7oD2WzHizqXd4Oc7ZPOY0Zrtcj4KRTZo0bpJINJLnodTF5Bsj6xNanr7wAH2jCI2e2oGNqDGyPNsCkajY7IrjIRNvoyxqB+6+borXP6JfNv85EJoGXvVwTeaPUx0LQ/jeXJQl77i2pOVDMUQeeJIOQhFF2kKJvoJOHWstDsX+Wx4hUk4AOKeUrizTzp7g47LTI5E9CK/Y1xVHwgw4NyjqXKCl0ifhcZc2mPRR+wYdFubM/39NZ4ULpX+rEMwDuHtr4qcdeBYlGjGhxsON4Xm+nheK4EswQRBnQWLgiI4iR427nBH91+FFuARMath3WR051g=;4:RENOaVghIO/gMTXNPFVCy9W6wbhh6ed99agE9IjKSZnGZBjCWC+4nuRdWx5HpTAtR19HV6fyhcYsTa8gEZ3HZLL9S7wEflrg9p4kQmz4s79LQuXxBz9VSElsTdmAC6nLV1Sz+PfkaIoWcNxEhgXSE3jMVO/ssKbbu3kMA0N55fS8PUKw5BgHO2frBDFIPlcyjcHOAL0m1+LnEhoRj5llnZ3UOrwoGaMbIvUrCxAIf2e5uvBNCy1D4NYfTRnK5WoG1J7MYrz3NFidk1uS3wLdPQRM7TeImOJTfbgqaWTROjngOkf66F0j9hX0MSzJTxvH
X-Microsoft-Antispam-PRVS: <BYAPR07MB4597CCCCF870F55759ABCD6F91940@BYAPR07MB4597.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB4597;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4597;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(39860400002)(346002)(366004)(396003)(189003)(199004)(81156014)(956004)(16526019)(5660300001)(8676002)(33716001)(47776003)(7736002)(33896004)(25786009)(486006)(72206003)(1076002)(76176011)(316002)(6246003)(42882007)(97736004)(2906002)(186003)(81166006)(476003)(446003)(11346002)(8936002)(4326008)(229853002)(6916009)(26005)(16586007)(6666003)(9686003)(53936002)(105586002)(44832011)(305945005)(386003)(23726003)(478600001)(66066001)(68736007)(33656002)(55016002)(3846002)(52116002)(6116002)(6496006)(58126008)(50466002)(106356001)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4597;H:hc;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4597;23:hKfwfeOWN8B0Sav5ZwCnnoSgpnoybfriw7OOGuMdx?=
 =?us-ascii?Q?xmxIPBIgm5/TcAHTVxBKdhslIdCuKqljxaYL2z0ijmAKVSswc+QpmkYi8Hsp?=
 =?us-ascii?Q?LbWHeFzbk3xzxM/LwnIz2jR/c/1iDfCEzZk8DGzMJXMBb1jkJfBRJ0vLyjAA?=
 =?us-ascii?Q?IYzf7+039jtfML+41plzDGOBrE0bni6Z8qVYdEAgoyu6yUAf/dDbY6IsEMnO?=
 =?us-ascii?Q?Y6iWvccrMbSEISBpd/v5+0OihZq+XWe5WaMdq5pByzBro6eiwzpBKUH1rd4k?=
 =?us-ascii?Q?LVbkXv+nOzVQc529napFClc9mLHyx+9J832fXvbmypXLMgMqUYDwbySIvQGw?=
 =?us-ascii?Q?J4CpXwA/D3EkJXveL0mXIA4YNfcf+2R4X7H+qi1EOTt4Y+izDNNvIkj0WLWP?=
 =?us-ascii?Q?3KwU3/aOz5va0kwGyi7d9UEkIKAucSijKrGk9TM5lBdQVdiVSwHUaw/BbiF1?=
 =?us-ascii?Q?sLJtErrFPHsmI4k1wvu1jTrA9tp79W4+Jw4+h6cr8Ek98+mV2EZQXclYMz2s?=
 =?us-ascii?Q?zpIvAnXPiAke0cSBjUbx9nlD267GAVpzFieScalrhMxxcZlbpWc6AhLMKu/s?=
 =?us-ascii?Q?kv99LAidiqJ32ELiHDEayBsoB+YWE8uOlOCtzKBnDuMWRHPxyP0rOhZVo19p?=
 =?us-ascii?Q?jNyay3Lp4HSFiJb9oCiEBfLbizCSA70nhLgR9ddCI6ivCDM/osS85vgue0gq?=
 =?us-ascii?Q?60ttobbo/KvR8P48IuiJtAH0M6ILsIkFCZUheVcYnSE4hD+rZxnfHisNtS2u?=
 =?us-ascii?Q?O5kj/NteAgpSTjl7euGB9PjMD7KrgicTulCGWu7b3EyaFdyWPMH0wVe52qxs?=
 =?us-ascii?Q?TJMnKtnZugLn5JI/vrIZxPCQ+ucjPyDFZSGEhbQ5O8gqX4k+wZiDRWqZlsZa?=
 =?us-ascii?Q?Og4C9Ny4vdBljXIad9+4gPKkxpI3QHJ2X0CCyKcr787MFSBSalyaoZEbVbjF?=
 =?us-ascii?Q?4K+O2FfAQAK5MbxgCC49g+XXBYk6jIRelyYfBH5nRwPE7DGHDHHGKirP/aGp?=
 =?us-ascii?Q?gwq5EJ2Cpb6u/Al8TpZfrsBCJFsLjo6UBBRD+dSYDYLJ7Qb73P+Go5XZZBK0?=
 =?us-ascii?Q?DQk2n03LYWHe29jtIhTnmO8soF6goDdlv3oFdu7Ww5R5yp4oQu1K6WjJ0/pF?=
 =?us-ascii?Q?C1SEajFWlo6BwhNIvOz79OCMHPS7y+eceQcwKUBSHeK4wnOKuDXdAD7mrwvr?=
 =?us-ascii?Q?hLPcGLR5eKNMh6nWIex2KVtpGnFc8DzDZlylUGGn8X4fFH177NKggwK6KCKc?=
 =?us-ascii?Q?YwFOp1H2XDJctMZGQXX+5GXbeY/YEIR39KXoBJgf9KLgTOLHnaXhoIsS3Bmy?=
 =?us-ascii?Q?aCfdO1XVGf46Jhp3bgSzY8=3D?=
X-Microsoft-Antispam-Message-Info: 9a72DcqnvuTloBe2NQ5fmAkQVCbsGnBXhJyNPlC5xvR95A/Ed1ribVM2zEMK1/J/FuU1z3zsw8Rc+Tax4ZY/s0S+CfbElP59F+ZrI8Kh1prVZb8JB9eBXL8D0IRNh+4Nl+tzHN37jlsNf9MjNwAjcjrCSUolzikjcn5uMjj3z7VLVTase01z4RhkerOND5/X
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4597;6:ZYTQSWGZl+iQ+t0mkvCxQ8SSOSPXthltZTS1Wlh3emcIBDv6xmiJrmT0PRHjVMjV9bOs6ejjM1ECExrqGXjZWimthC1nt4pGZ3MMXNrDVA2FfyBCJqxJ+LTXOUXzZahEdCMyCfczz6EAVoYqsvnwuumEzgcjHDRatbhBe+UyImsATYTMpuhq2zIlVwOg9OA3oJDUY1az+rxSKJfl/P8Y0OBvJ2R3LDf2DPp238gwCVVihqsdW3wpf9senf55XJ+C0e2MNVK4W5bECJYMGTuhW+7ViAy3KJxeawPYv50H/hMGIhPfF/8sqkEAiuVD4Csz8UcqzBI6bevFLmEqJ+aj/12WJE2tocnXeFVVAqWWZ3jBdTFGilx29OIQw8zIgtu9clOXyjmuZE3fiSC9RnKwP+fYbJBiJjtd9oIityiBYRQYfMrN8mY8cAUbl5YSP2xSKgAhX2vHDBXN9cQrfEr/pg==;5:ojPij/ygXFfg+mhVoiHCe5NO/JvzwrRZHxCcnmgoOhCw3xu16QiGOJSPI6AYgRVmvnLrO7B6Y3pcvOkVI8tcjnbGezMWFw+1XqUmiAE+itb64ieeP/Zil6NeQs7GEDotmlRgdqpW2dUPc7lvIz7YuJcTQKIdUrZXWPovAP0wLc8=;24:DFpVDyd68dwHDm6+2Z8UCLlwGfjebCI5v/vWwfrsF3gqon1BqRXRofeOdEuVV3OavOAyppzB+B3UpRPUBNCNwOHOHmPawzNrFapcuE/b4eM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4597;7:JFA7J9Cz+W7I7+TfhvuRdvIOZ5L44TMQ434+d353OW4fxSEri/wMQIXgwGOxH95FCUs4PwqnqAfNwMVu+X6Gw3j6ri1SpJKvkjAQyE4w8NDSbHeURUVu4yNHrcEdeccwISJ3WYHbeWI7JNTgysO3fH3IQH11QwTxlWwhWAofvvTIkOwm7oV8R9ryBwBZrV0FfU5br9CUgYtoxpww/ihsm/aujKOi8G00/ZgVMjjixnsuBXcoD/jLqVrU9XtZYUj8
X-MS-Office365-Filtering-Correlation-Id: 140779a0-a5de-4266-5dcc-08d5bfdb4525
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 11:57:59.7345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 140779a0-a5de-4266-5dcc-08d5bfdb4525
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4597
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 01:54:14PM +0200, Wolfram Sang wrote:
> On Wed, May 16, 2018 at 12:00:19AM -0700, George Cherian wrote:
> > The i2c XLP9xx driver is maintained by Cavium.
> > Add George Cherian and Jan Glauber as the Maintainers.
> > 
> > Signed-off-by: George Cherian <george.cherian@cavium.com>
> > ---
> >  MAINTAINERS | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index df6e9bb..68da265 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15509,6 +15509,14 @@ L:	linux-kernel@vger.kernel.org
> >  S:	Supported
> >  F:	drivers/char/xillybus/
> >  
> > +XLP9XX I2C DRIVER
> > +M:	George Cherian <george.cherian@cavium.com>
> > +M:	Jan Glauber <jglauber@cavium.com>
> 
> Jan, I need an explicit ACK from you for this change.
> 

Sure:
Acked-by: Jan Glauber <jglauber@cavium.com>

Cheers,
Jan
