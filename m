Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751228AbeDSIhV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 04:37:21 -0400
Received: from mail-co1nam03on0060.outbound.protection.outlook.com ([104.47.40.60]:28593
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750799AbeDSIhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 04:37:16 -0400
Authentication-Results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=synaptics.com;
Date: Thu, 19 Apr 2018 16:36:57 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: ARM Maintainers <arm@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] MAINTAINERS: update entry for entry for ARM/berlin
Message-ID: <20180419163657.276b1333@xhacker.debian>
In-Reply-To: <87fu4jt883.fsf@bootlin.com>
References: <20180329164240.20cfddbc@xhacker.debian>
        <87fu4jt883.fsf@bootlin.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: OSBPR01CA0005.jpnprd01.prod.outlook.com (2603:1096:603::17)
 To MWHPR03MB2639.namprd03.prod.outlook.com (2603:10b6:300:46::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR03MB2639;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;3:4HqZ6/a5wkVM9L4j4yRSLdx9OVa425j9OLjSfOnm/mCn+6xNl485Ooy5V1L6jue/N/HQ6sv3e+ANa6uEwKwnYg4nQ+7E0Z07pzqIiNXWbd2+j4A523CJvG9+KtdqdIBz5BuRuUqNWWkpNwYELnNtiI7MwHN8jYkEx09Ho8JeuCafjVEIaWJa4dLUGv/rAuvYpxMwJaN3LOthzmErRxqUu8qWQjnl8k/MS3SYOHuQTZCssc2VZf3wf3jHGYVk4atC;25:wYSSkVE6UWbxloVizqC0wfDxEjy8lNmPXtZeOsefMWcD/gHHYD1w0SpMgd/1Gz+m4sdn8FOlL4ExT2Aq+2Q90v/jR3jEKph2W8yD78mWE6MhMUdG1ejpzI4iM0BafjmkduHBdYDLYOgr9Fso5Ko32xdPSFVB5XBKdU7y1+CIhS0qO9V0HQ9QKdaRqrW7gYpN3IvaCKr+0cCCHedlbscw0qtnQGqWtZ6BQbowCji5F9gyd0bNiPeKTqs4D7Nt8ZKgK7KYhjmcSr3+y0JrlvT1kkHGk8+GPX2btbvwsvkDAAhAwhJjWNYoUeYXkJpKgBFn8LTFOhC8VQ0oJZex8GeLyw==;31:CjXapYEtiSk3ZplDPffuNBpttSrgP67DhHZMtF2qsfrdh4EWlwie/jgT+VG4PHmLEh2gv9nDusnZHO9InqJO/XJmjGWyjXLp6oY+yLLyZ7f5Y6Xf79YvSCPQL4sa9vE7/Xy3jRd8ak7aLLDl+2reTbKikxYtQJ4PSrRg7B0vxsdEPfAZlOi/vckrBcLMbdkoO8HndHcwqFCxauSrKKp9su87gu8AjKeQoG4t+K9xGe0=
X-MS-TrafficTypeDiagnostic: MWHPR03MB2639:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;20:x1/pgFjVHcColxtAbzQarWWkQi2GnqTAOgg4de8s1/0nSrEWgcQlPRhkPGDg0taAAh9ij/io7WpMuQq34Ofxq6rdcMIksvnMz8ogL4X2mp1mYxSlYiQl1o7KSaH4rzPPWZfZv4aBhQa3W11bW6EZAMV/NffU+iXNDhsJlnYGfrRzRy+MvYle3f3CKCH+SndQHKrEGSUWLYLZlbtMMeLWUeCnfN/MbN2HmFAYYIyxlpFIGLqpC5eUKcSOcgQ5LmOQfJTMNZMlEPbqIObtAtXxsCEHSHQiBcCMzhIc9oNfpTMEKXSCcOZj7n4SXstsQwJ0Sa2yC6qavGYXtEE2wy+zzphFyAM2xmydnpJdt8qs42Sijo3druoLts1/rAwTwpeuqjM9s5W69qVNuYknKBN2cnPEeaexBDF8vmblVlkLM7aKj6mBmYtZe3BBQZPbmjNIyrp8vPwPpiboBC2j9dz5Nl+x8CXP0AsSm+GOEpiK0j6SuCEv6ZrXP4WsHnE+nGS8;4:NB5L8STd4b/Uv9lktEW/uLAd9k8m6fGZF9gN8mN6aS3d0lqV/+h53xl6Ti+jwHpCqFIWv3fQz1ngjgDK4mQQTbu0y56bCM0e3o/ELbwy+7Nr4iiuiG8m3HQiabQLVDt9O5DvX2MPrkeNyJ57yr+uW1jszMNQ2rHvgb9DhZeb9TiLg5ADabtKdU620J0I6zvDOBOk1piv5gns9AwWbX9cXFcQZj24ZZ8UbJzGtlWhieI4BSbUYtlBwmMgsWIH5GdrqeMTGmrSvBvyKgdWAnMTeTk1VA/u1c4YnysDi6OfWt67qMfPHV1s6W2peXVqiQWkVCPfUA9sRWYr7KA9NWcmyGRZ0nZBybZyn5ptL56okM4=
X-Microsoft-Antispam-PRVS: <MWHPR03MB26394CE32835CDAB000BEBFCEDB50@MWHPR03MB2639.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(258649278758335);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR03MB2639;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2639;
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(230700001)(23726003)(6116002)(3846002)(229853002)(16526019)(4326008)(1076002)(186003)(7696005)(8936002)(478600001)(52116002)(33896004)(25786009)(386003)(50466002)(2906002)(26005)(76176011)(50226002)(72206003)(316002)(6506007)(66066001)(81166006)(86362001)(305945005)(7736002)(575784001)(15650500001)(55016002)(6916009)(476003)(5660300001)(9686003)(53936002)(956004)(446003)(6246003)(11346002)(8676002)(39210200001)(19627235001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2639;H:xhacker.debian;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2639;23:J4bggPxgiLVuLK2eVEoSJwZfevBvy8rNY/Mlrf/pb?=
 =?us-ascii?Q?SmUUUyEVNjX0JLUyVKIHSsl0zvwIzhG3k+/zHG3cs3K96MsHekb/fgYJh/rF?=
 =?us-ascii?Q?immh6loXUI5asd5rRNfGN4AIxyzsRzRYhWnRQ79NYe+BmgLp2DqFuS5/dwan?=
 =?us-ascii?Q?LBiI9jafViL3tZ7DfCfbDlqtUYljk7HvUJYmkB+G2BRzKdasHnCVq3IE12mX?=
 =?us-ascii?Q?iyUTGLyDX2lSiRD74FH+dkjMjzFyHRh9sc7Ox4AWeq1yY03YdOhxw/j1tK41?=
 =?us-ascii?Q?vEURc4ZkSTDEpQFBLZFmrhdXi0GjZ8qQGZgGKATRtKmMEUp2goSv8NLFXt59?=
 =?us-ascii?Q?SIjuJJpJZ5AMUE8hAlRpf4I20YK7Vgyw+DRKMwVlDFtyTnKwpOWxHeqpjPN5?=
 =?us-ascii?Q?O6lfBwMVKAZbbukc3PrDgma+aS8KJfWvOmF16qk3KqEsmf39NJS1AitRLgjG?=
 =?us-ascii?Q?oEr/DW99yj5M3U3FFF/iR7jRIuos0uBLJanoXAi/CuRCRsCuAEeQ64DKEX/5?=
 =?us-ascii?Q?09qeOONdfmq5elbWy4VHLpZKXaIcUWcJW3YuJQkqtF9PmK9enn+c5snohehQ?=
 =?us-ascii?Q?DBTfrhY3bkqVv/+Q2jGQ9dzMFSQgeQstAReliwQPpELnHDbIcLMrxAP4zPAu?=
 =?us-ascii?Q?+Xj6SA1ls4rB/sbJJqOPysw059I2WXLHWN5jxAT6FXybbzD1fVh5V/HbBEiY?=
 =?us-ascii?Q?r8bLczH1opczHivq9Swtwg/9kGagqHgN1SIWouReyzpnroqPhQQFBKF3Yqal?=
 =?us-ascii?Q?Zwx9ql8yMyXjt5tyzyFea3uakqru211STve70ZqMo4Z20LU12j3fJQSJ+Imu?=
 =?us-ascii?Q?lg7Lo7EUqPR44TN/PDPwRq5F+77Qkq1woco5Q1fX7ph1XAV4xbx+22TQEAIu?=
 =?us-ascii?Q?kuJ95bB2OK0aCd87D8g9fmWswyDJb5KoGxe46ByQcwHWkrTNzzDPhh8cR/yI?=
 =?us-ascii?Q?h6iRaR7hZpQrsnYWign9TxdEIdTqcQKWeXsEdpwlvRtsMOvXZnJkwOnsVMSP?=
 =?us-ascii?Q?DkToctCvTovJOp2zHdPGYphRj8qmIFIuLB6UbMbk95FeHDN4AJJGXK4hVExB?=
 =?us-ascii?Q?LWAW3rtdmBGZGLmuACNFadtj21OdEqgBcCmYb+YbcLF5jfL9u/pbyPTHLLLx?=
 =?us-ascii?Q?dPTOYWbTtP1x0cfO4WSGqiZWqY87Z4m?=
X-Microsoft-Antispam-Message-Info: 7TKiKv0DBY6SAqjf3mx3tqblVu+UvwVqouHD9M6GPj5zMy2z5Oi5GINPVc6GUIdqwWHxilZcCIGJdJ9O5GoV+0FgwvzfTDW5Y8jH8FRiVDOJViJnbHjwlELtWUn9loYaI/PB+W9tRILRAkoZytZWpY+kFn5Mb6lPNOT3b2lEb2r8/O10r/VS/hk4ydIoZ13w
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;6:a9awI46Fn03esQP6cm0iczbrAa1TwfSKQUzuAsbHGnSFFf6U2HHPt90z1Lc6//Zuueor6EbfIndzMFMRS7BR4xJKfuuW7JgYiv+s28BRhqluSh0WB9QFHZBdd2qAU4Oh8ANdzjtOzxCLo9rKymRaq68bfv8wUd+n3cwT8asu4g0toCk0lVNNXarhhSuHHRhiSlImmavHac6rIJ8d+1WBteEZ86sjIFjqhj+LvVwoYU6YuqMXyhBMTKluU7tUSvTEcqMacJUg/8vH8ZVU1NuoHRnNV+UUhxycWHFZl5Nh+Om7TXzwH2QuS9tKY0uQj4VCVJ1GNrBCzelZzECFYpcIBDCRPtF/zZRzUGhBUtmuQFR85MWe4gnASuv0CAJG6/JxN5lYIEfi0kMnOZ7n9xEWCi6NFTS8yib8iz75+78MclzQNe8fkL2momEtQs1LSrPvgT7vf00knNGjjGGYAaXqrw==;5:3e5aC3OzgLvjG2uw6xLOqF5tjO6S4t2OAPp7j9qB6u5cuWqnviHK97oFp6zrGyqsXSjElN0b8wpksM6oP5mc3w4QJjqRACSqiIyuBc9Ej/0lTqOImHnFP8uXRfCW2yZNHJ1Qp0QCFt6IjzmKP0k4lJ0STfNUIR7rXriJkOibh+E=;24:PDcxiLX6JnyExuOzcALotEXaKOorY+0ij8U4jyNSt75BMbY7CD1LP3PRZPQt50p9aSspICXGAjlkfZjRPjGoEuz/hchAnMUwU8TvDr3ujsw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;7:rm/F18z/HGvdTSP6Y2g5u581adgjxGs96vHdNVPqIIwb2o53tNwmIQgDoBS35phUai+/LkBV2E5EkuxtlPuY68FyPNCTTH72hSUuhzZcwumAT8cN0DKZGaN/au/yXSqHm6Fqg/FCng/O2wcjCSwjqX2Qi8piYo28/+YgrrcExppEB/ZyMyQSD9nA37mfL5wEJpeGOfnWHItWMB/gMbcMvKfA8WsI/67kcarH8h7xa3+F3ZHlWwZLrslcbBPlBqWp
X-MS-Office365-Filtering-Correlation-Id: 41f59fcb-9f4f-42be-5886-08d5a5d0bf92
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 08:37:11.7675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f59fcb-9f4f-42be-5886-08d5a5d0bf92
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2639
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gregory,

On Thu, 29 Mar 2018 13:46:36 +0200 Gregory CLEMENT wrote:

> Hi Jisheng,
>  
>  On jeu., mars 29 2018, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> 
> > Change the entry name and move it to its alphabetical location.
> > We move to ARM/Synaptics instead of ARM/Marvell.
> >
> > This patch also updates my email address from marvell to synaptics.
> >
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  MAINTAINERS | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6e950b8b4a41..0a0da6a8e607 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1578,15 +1578,6 @@ ARM/MAGICIAN MACHINE SUPPORT
> >  M:	Philipp Zabel <philipp.zabel@gmail.com>
> >  S:	Maintained
> >  
> > -ARM/Marvell Berlin SoC support
> > -M:	Jisheng Zhang <jszhang@marvell.com>
> > -M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > -L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > -S:	Maintained
> > -F:	arch/arm/mach-berlin/
> > -F:	arch/arm/boot/dts/berlin*
> > -F:	arch/arm64/boot/dts/marvell/berlin*
> > -
> >  ARM/Marvell Dove/MV78xx0/Orion SOC support
> >  M:	Jason Cooper <jason@lakedaemon.net>
> >  M:	Andrew Lunn <andrew@lunn.ch>
> > @@ -2006,6 +1997,15 @@ F:	arch/arm/boot/dts/stm32*
> >  F:	arch/arm/mach-stm32/
> >  F:	drivers/clocksource/armv7m_systick.c
> >  
> > +ARM/Synaptics Berlin SoC support
> > +M:	Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > +M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > +S:	Maintained
> > +F:	arch/arm/mach-berlin/
> > +F:	arch/arm/boot/dts/berlin*
> > +F:	arch/arm64/boot/dts/marvell/berlin*  
> 
> I though you had move the dts file from
> arch/arm64/boot/dts/marvell/berlin* to arch/arm64/boot/dts/synatpics,
> according a patch you submitted in September.
> 
> What happened?
> 

Sorry, I didn't see your email until a few minutes ago. I have corrected
the email junk-filter rules.

Yes, I sent a patch which did the moving last Sep, but I didn't merge
it and sent out PR, I plan to resend a patch in this development window.

Thanks
