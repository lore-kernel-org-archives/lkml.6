Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754084AbeDBC24 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 22:28:56 -0400
Received: from mail-bl2nam02on0065.outbound.protection.outlook.com ([104.47.38.65]:41478
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753989AbeDBC2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 22:28:54 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Mon, 2 Apr 2018 10:28:31 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Andrew Lunn <andrew@lunn.ch>, ARM Maintainers <arm@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] MAINTAINERS: update entry for ARM/berlin
Message-ID: <20180402102819.599ac67f@xhacker.debian>
In-Reply-To: <20180330135932.GB28244@lunn.ch>
References: <20180330110211.36455347@xhacker.debian>
        <20180330135932.GB28244@lunn.ch>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: OSBPR01CA0011.jpnprd01.prod.outlook.com (2603:1096:603::23)
 To MWHPR03MB2640.namprd03.prod.outlook.com (2603:10b6:300:46::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c22fc1a-3427-4a66-0384-08d598417960
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR03MB2640;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;3:UokJ2q2UAvZcoOXhYzjbUexn5cgO0t8oAY2QTwBbjmG94mBeekMRRHQ9rxi4IvFEcHbw/od48sKKpvLiHPGfkut2ndux2pc7dr2ZQefQo+C6lWAtikviM9oI/oMgaXVIZDzmLAFxAX/wFpetuOPhAVrMSZlX+l79gpgmL3PCgTpdAZOTSaU4Ek8sdYW6WpRZA2eChn5BIY7Sop++hpQEbx+XIF0gI3u1pUz9v6reTsgBcj+FOokvRTXfNgnBHoCu;25:VuS2vAlTLXT6zkLlbaQbg18cO+9Mp6YMggXZmW/ZJrQmB6YcIZQPZm2WBprJGB2uNZtIfSANWTBmW+KqViVV27w+AqS/iKlOLKz4wxX7Tv4dTvICQ2c84bbTFXd3oW8kDYK57/F116Hp3ndSx+TcgcXKd0d+YoSjO1l7jGB2VkjxIzjPM8VlfpxMOdN2go6lZlVmhyfZ2IDw1mQvLdQkWTg+tfsDXB2YJLIISOXPcIAOvNbzKyn0pM6w/vrxe87tfnbmsbRf/XBygeT9TH4V5plC6yKbYMSeGJXh8O7KFOVd8/jjz+ylbYbxl3Ni8i6cOQO50rPP6jUKgHzMVwI0Uw==;31:rPcn1+JZkJqulhpqG6KYFpBJr1nk6VBsuW3uTMStxXEcZNP+atgaQTQennyROLa1AfgU1U3jQCRFaA37K81YtaWWTXoII3+x6QZFJCbhaGOyRuq+TF8dAXo5JHmIryJD6r0eKfvubf3EqxwtqmUxJu22DgZZVI4zaoOQJbnEDsxSU/uwHfXkoTRo2swwxwu4ajttAhbkmVkRyek2TFyJQz/MxkXPdgTd6J0RLgEztPE=
X-MS-TrafficTypeDiagnostic: MWHPR03MB2640:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;20:3eokUhs8oo7lizWPOAWHLQZwlwAQ2EkBhBD6zaWSgjhyMPtEk0cUD/thBr6XtT02gXXCw3wuixJVIhQxIppwquPiAlRDbAb4sgpWOZk8OGrUfMCyZzqTAedTMlUJeHHRfRpANfsZ5G9rHKKcdIyFkeYft53VHKE/5UqNwHP/luBV4Pkr5B/gQa3lxqouqULIkP1TyLuL7lYbMPrWzq1szot41x0frju0sKymuETazota1U686VAXsTxZik6oHJm+37uNVm1TBxsTsrU45JLksk8+tzkFAECBPkKkzrpTeP+S5sx2aRjZo0noPZWw0hpN4VxmetXoip+ypDLINoQI+1AwRHRk5sCtmCFTNCfDCXkj1VEiBROc0Ttb2P6ZeCLwW9CwSvZDoFOHpImork13r50wGmrrhcwhdeteQ0AF1maKBDgWrtSbe0inhdLVa8Nv7toKN8gEb8u0txnMacS89ox/ql60+bT+sgMmgTqvzFkKviw55UDf0+U+i7OeZBo7;4:0MqJTHMir2ElYB97NuAxdZGsfbf4/LwTkXSFQ9+d2Ef6J7VtkpcNYSNsWtGRpyCEJPKFk0JPhUyC/lSaqFMocYhygXBIOdjprkEhreDQ464F3mpqIq4yuX3vkeChxnI9jlzWZTsBgsMc/xs0D/81iJWDKATjNy5rHvgIKkm9cSqrJaAoUvFeb/umOpHNkpWS8Hw6FLnfrN0fOGBjA01IoQ13CJumVTYfXfErA2vPQ0w38yDYS6jaq021NTurfwV/3fj/aS1/iXcAuEfR9pOI5w==
X-Microsoft-Antispam-PRVS: <MWHPR03MB264033A67CEC14361F665514EDA60@MWHPR03MB2640.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR03MB2640;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2640;
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(396003)(366004)(39850400004)(346002)(376002)(39380400002)(189003)(199004)(51914003)(111735001)(51874003)(86362001)(230700001)(6306002)(110136005)(6246003)(966005)(72206003)(478600001)(8936002)(105586002)(55016002)(53936002)(97736004)(50226002)(106356001)(9686003)(316002)(66066001)(956004)(4326008)(33896004)(47776003)(76176011)(229853002)(52116002)(5660300001)(305945005)(2906002)(476003)(486005)(486005)(3846002)(68736007)(6116002)(11346002)(8676002)(446003)(50466002)(25786009)(386003)(16526019)(6506007)(23726003)(15650500001)(26005)(7696005)(1076002)(81166006)(186003)(6666003)(81156014)(7736002)(39210200001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2640;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2640;23:SFhT27rPfPlhG4yD1+LaTvyrlQJnIahZW7nUfgOx7?=
 =?us-ascii?Q?d5evxFqy3ycp75UXE+bLlBZeliUT8etv+Y5zgEpTe9WG4YLRJNZbKVWvsTg+?=
 =?us-ascii?Q?DAHOpLvagEioZnPCUiL6xsvCk3Lc767Hi94hd/ox5ud5kGZ8OjLOfcx3tvIe?=
 =?us-ascii?Q?YwZQyZVBwYpwyiPGlQ8OGX9X+TFbIZQCgPmFrliBYvGWu7fJFI2Wk1D8liXA?=
 =?us-ascii?Q?y9PDjpDhVXT+oQERFPwa8lBL9+kUfmYRRyrTSDAajMtNqqltuWinfiXyvGFQ?=
 =?us-ascii?Q?lI6/hYOsDMYSmDEZq42LcCET2RlqZQieUp5I14OL9Q3vu6ggRzo9/uSTDFZQ?=
 =?us-ascii?Q?jfgHWFYHvkXb5BEsZDBxwv0Vs8/jc3Roh9lwx6hxNHli5L236WMYPIjdD9xx?=
 =?us-ascii?Q?Fyl6yP8jYVBCOJSdC5IxxVDE1WUwEmGlIYWx7rdOOovO/Zc6379aQXHq1kEZ?=
 =?us-ascii?Q?z7rge453jGFW3Hrr9MINwJrVJPbJAGrnhDNi4pzIni4BaY2+rTHrzwk7Ycbh?=
 =?us-ascii?Q?q4MKx5OUbgRpUh7sOEgq5e180VwGQSgXvP7/fRzTey47cEgJeqLtlxuxBCMA?=
 =?us-ascii?Q?RUXHr6xFDFhbJHghQeVigq1C1pMjo6SZXBdb3P/u+6+LvJWiwSC3oqdtm0Y0?=
 =?us-ascii?Q?BBf5LhgQSggmJL5SBuNd1u2ieocRMHOSZcTFKriRNVZVerrbzc/vODuI0X5w?=
 =?us-ascii?Q?U1pLMEp4ENEpCYTeH7G1Kbg98EiuI7qIQefJcVIvo4xh0dFub3qGm1/4Qd8W?=
 =?us-ascii?Q?6BUrciCFDd0fQQIlQl+LhgKBocYInYUXnQFIQwSRcyr38TiJPf7GqKtrEARc?=
 =?us-ascii?Q?OtEqXmzOl1zB4d3T3jtYUy7ZOVm8J4ldrAeDM1COqDkqfb9f6nikKJ+HAaOG?=
 =?us-ascii?Q?ba3tdQjr8AYzTChp2V3dhmXYK468VD8MMlwMhSbuU3Sdk/d0pzfboN1bqG+v?=
 =?us-ascii?Q?rkfQ3xya4+2/XKWDW4ghrB9PmaaA6vgbF58b1vNJrYOwMJE99k/t7wAm9Wtm?=
 =?us-ascii?Q?GGp4hp3M7OwcCRF3EQFoluEh9aCfuHkBQZmXW/yG124VKT0iTQOM2eusSENK?=
 =?us-ascii?Q?mPZqKHa3jr11aQY7hYt1j8C9KR6hd8geWXks6ntLk5ZVOSAgUwOvgNfyUBkL?=
 =?us-ascii?Q?LnPj6K/U+VwzqEEHjY9I/IeayDweZdyeeZzQc1sT6rgyH/cRreMd68s+UPg4?=
 =?us-ascii?Q?NV23hfhMYSyUjXsYo9GtT6tPLcoITK6qEhcvLSNNusbx2++wt1LKo7N3q4KJ?=
 =?us-ascii?Q?TUEBeJCjiUKO6S4724FMV7GzoxJu1R6VhW9cFwPC8+mTTLYSVNBrGIuMUWeg?=
 =?us-ascii?Q?RtnuLZaZHQEeERJZbAyYcOsox1iMHBtnDMMlt4owS/Nw9s4cPDpuz9KeaNAE?=
 =?us-ascii?Q?QkHEGGi3VQLt7/fBFs3+Ji9A/8R+EsXnktdNccUypQQwynMJhhRf1MvBCHz5?=
 =?us-ascii?Q?Yq5Hzdd3R7yNNpmm1IATKNB0GnYEZ0XWuiHXJytgDotdeonwWdgSudlqSDVL?=
 =?us-ascii?Q?N1XTVJTh8dARo2EDC/FPzQC/MACEyzv2bc=3D?=
X-Microsoft-Antispam-Message-Info: wtPoZ7hooDns7i6TLEvxm8k3109oC1l8sxk+PitV1hBGwRgxhmG3ywU5y1zeSi8l+wiLLiGONuyCqzD5b+HexqZtFvfSwbzM2ni4Uj2Yc688XpObV8ytOBNtZ1iAuhTsBWQzflRBo51bWQXWRGmLy0nzCyjS0TRgiZPlEo1VjNhNTYO5vX7K5y0Rf03f2hob
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;6:7jy0v+RmDoH2HjqsSiSKPZiNCL4qwvIQWWotprI9/j4H38WKXU08BCXXOOnvhPGRhCvHqe6K5CbtF8nECNIObn9osGXWD2JIbBRwNO8CvItsoMuXC06yITpkOm4UaCL39YGjCKdWgKOXgmzTmxDTU1WAWrk5J4RaPq8Khy60JhDlX2qfLVZi1Uv35XTsFKjDriUtL66MXAyWqQJ2sB96D29w0HMDyNB8pzCcLHrnj8UyNjmeectq+uyNB5QVrrAOogU3x8azdlHYcYoQpWIi9FL7VS3l+jlY/PYjKNlkG8m5Fj6XFKKevcJSc1b1Uxk1FWQ/Ld6EayibA2RVMQWwlbYVjhSBqLK3Zh0JN9RjmrlqXBdcxq/kzs2wZ1VBGclfWPueOPUUrZK2LsOtWh8UsP8+awpy3map1gbQ1O+RovthBvYSxhhuc5nYsO47htR+WQoQKSzp33X71IXnpXGxrw==;5:jJbLEs1A1xxdNwP3sbjLYzuRQ+U73YY6LV9EVL4odSLrvrXbVTksnsQS8lIvZC2rBfZRKh+8L58o8ScKrinlCzyo2irt3sbgOOnskslZKHbN9bfH7wsQhWdOeu4ZOQsEVetwqVxX7ghTLlmp08YluJklz/z761q3JyrXWAVpVTE=;24:68ZkXJRBFCRZX4fNz0iZKf3jl12vn7Zw2k4APu+ypbHqWv1+1aKEetZiiHwUGmm+lw/pgDOI8DOX7sJUC4VL/x9UOUNX7ZetMJreW6Y2ULc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;7:IxDZWreBy+ZmGmN7DDpKsuBrtkpE6zF66M0P/ABUHZH/u2VZQ16oqH1m+Um9dS5Vyicq4ozmFJzXECpUl9KzlCtEJy6SWcqnPAPjHNw4g24nZvt09TKA+Y22Zoe7ZEvJ+Y9RI9mvyV0fE8YpvYqCzh07bmbd8ProeNXHKFf7PYP6rv8JcO9o9/IwEdIQvNRLHRNhK/yzNWxdmr5vjREAYJ/DEgfYajsIf7me3rG6S0av1D0RqjyY4Bk681Owx/p8
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 02:28:50.8375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c22fc1a-3427-4a66-0384-08d598417960
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2640
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2018 15:59:32 +0200 Andrew Lunn wrote:

> On Fri, Mar 30, 2018 at 11:02:11AM +0800, Jisheng Zhang wrote:
> > Synaptics has acquired the Multimedia Solutions Business of Marvell[1].
> > So change the berlin entry name and move it to its alphabetical
> > location. We move to ARM/Synaptics instead of ARM/Marvell.
> > 
> > This patch also updates my email address from marvell to synaptics.
> > 
> > [1] https://www.synaptics.com/company/news/conexant-marvell
> > 
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>  
> 
> Thanks for the link
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> Do you still plan to move the DT files from the Marvell subdirectory?
> Are the locations of these files considered fixed?
> 

For new SoCs, the DT files will be put into synaptics sub-directory.
But for existing arm64 berlin DT files which currently sits in
arch/arm64/boot/dts/marvell, I dunno the proper solution. Could
you please give some suggestions? How do other vendors handle this
situation in the past?

Thanks in advance,
Jisheng
