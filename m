Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968098AbeEYTYA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 15:24:00 -0400
Received: from mail-bn3nam01on0080.outbound.protection.outlook.com ([104.47.33.80]:58003
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967587AbeEYTXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 15:23:55 -0400
From: Jolly Shah <JOLLYS@xilinx.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC: Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v6 09/11] firmware: xilinx: Add debugfs for clock control
 APIs
Thread-Topic: [PATCH v6 09/11] firmware: xilinx: Add debugfs for clock control
 APIs
Thread-Index: AQHT0QOvcs9sdlbCTkKDxq/bPR61b6QpNRYAgAaY/fCAAOV+gIAQZcXg
Date: Fri, 25 May 2018 19:23:49 +0000
Message-ID: <SN1PR02MB3758876A011FFF46C71C8F6CB8690@SN1PR02MB3758.namprd02.prod.outlook.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
 <1523389127-14243-10-git-send-email-jollys@xilinx.com>
 <5bcc47f7-3352-f0e6-29c5-78d5be96c1d1@arm.com>
 <SN1PR02MB3758191654612CFC261A38BEB89C0@SN1PR02MB3758.namprd02.prod.outlook.com>
 <6579fdce-6845-70d5-1dc1-64d52debef19@arm.com>
In-Reply-To: <6579fdce-6845-70d5-1dc1-64d52debef19@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com;
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR02MB3742;7:Ynhc72x5s8hyWo60mwou+H4EA8+Ci4wpqzbWbXm/mE7djMAE4v8TkRePZx5uJ5dO49Imheyv7HK703aUn+7C+CdxHgCutQGVV44/knvY7JfFIzYOTNG7cdw5yoL7KmAaTILIImT14k16Kzc8SKvWh4gSdaFp40ZADSpWC8pJTdzW8V2WuMR2HBabndlriSCrvy49kuGns+j1f4WFJzcth2hegJtmy4+Zw0QIOXZX1mH9cIAf1VxRtiniX3iDmI4C
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(189003)(199004)(13464003)(7696005)(99286004)(9686003)(186003)(76176011)(53546011)(6506007)(316002)(305945005)(74316002)(110136005)(54906003)(2900100001)(55016002)(4326008)(39060400002)(26005)(25786009)(6246003)(53936002)(86362001)(6116002)(3846002)(2201001)(2501003)(5250100002)(6436002)(11346002)(446003)(7416002)(105586002)(106356001)(97736004)(33656002)(229853002)(14454004)(478600001)(3280700002)(93886005)(72206003)(102836004)(68736007)(66066001)(2906002)(476003)(5660300001)(486006)(3660700001)(8676002)(7736002)(8936002)(81166006)(81156014)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB3742;H:SN1PR02MB3758.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR02MB3742;
x-ms-traffictypediagnostic: SN1PR02MB3742:
x-microsoft-antispam-prvs: <SN1PR02MB3742960BAFB63E23E19AF3F0B8690@SN1PR02MB3742.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR02MB3742;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB3742;
x-forefront-prvs: 06833C6A67
x-microsoft-antispam-message-info: rbncOFtP40B5LIGVnqhEnJxrEnRYVJM+2TH8NF7HMfQetvX9pntmc5BiA/UcbOj/HlWC8oVBglirX9UXu20k3XZJMUaPXQ7kqSOX3c2XYnOQYEdXhyybU9z7EvnGEOPWFH3uf6r+cAHQcYSRAgPRG0+JdrKyop9U+Q7miIshiWSk2Ut8oKhIBUHI7uc7Tq2g
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d7899737-84a9-43b7-b46a-08d5c2750b0b
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7899737-84a9-43b7-b46a-08d5c2750b0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2018 19:23:49.4161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3742
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4PJO7dO013577

Hi Sudeep,

> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla@arm.com]
> Sent: Tuesday, May 15, 2018 1:58 AM
> To: Jolly Shah <JOLLYS@xilinx.com>; ard.biesheuvel@linaro.org;
> mingo@kernel.org; gregkh@linuxfoundation.org; matt@codeblueprint.co.uk;
> hkallweit1@gmail.com; keescook@chromium.org;
> dmitry.torokhov@gmail.com; mturquette@baylibre.com;
> sboyd@codeaurora.org; michal.simek@xilinx.com; robh+dt@kernel.org;
> mark.rutland@arm.com; linux-clk@vger.kernel.org
> Cc: Sudeep Holla <sudeep.holla@arm.com>; Rajan Vaja <RAJANV@xilinx.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org
> Subject: Re: [PATCH v6 09/11] firmware: xilinx: Add debugfs for clock control
> APIs
> 
> 
> 
> On 14/05/18 20:18, Jolly Shah wrote:
> > Hi Sudeep,
> 
> [..]
> 
> >>
> >> As I mentioned in earlier patch, I don't see the need for this
> >> debugfs interface. Clock lay has read-only interface in debugfs
> >> already. Also if you want to debug clocks, you can do so using the
> >> driver which uses these clocks. Do you really want to manage clocks
> >> in user-space ? The whole idea of EEMI kind of interface is to
> >> abstract and hide the fine details even from non-trusted rich OS like
> >> Linux kernel, but by providing this you are doing exactly opposite.
> >
> > No we don't want to manage clocks in user-space. This debugfs is meant
> > for developer who wants to debug APIs behavior in case something
> > doesn't work as expected. Debugfs should be off by default in
> > production images.
> >
> 
> Good that it's not used in production image. The clock layer has
> *sufficient* debugfs support that will *help in debugging*. So please drop this
> Xilinx specific clock debugfs.
> 
> --
> Regards,
> Sudeep

Ok. Will remove them in next version. Let me know if rest changes look ok and I can submit final version with suggested minor changes.

Thanks,
Jolly Shah
