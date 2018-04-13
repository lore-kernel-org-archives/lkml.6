Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751171AbeDMEas (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 00:30:48 -0400
Received: from mo-csw1116.securemx.jp ([210.130.202.158]:40194 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751041AbeDMEap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 00:30:45 -0400
X-Iguazu-Qid: 2wGrbDvdyfvhAt6mX4
X-Iguazu-QSIG: v=1; s=0; t=1523593836; q=2wGrbDvdyfvhAt6mX4; m=zZj2oj/L8DM8knbf9YQOt+za3isBRDxb+65WoaaYxOM=
From: <shinya1.takumi@toshiba.co.jp>
To: <serge@hallyn.com>
CC: <jmorris@namei.org>, <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [RFC v3 0/2] WhiteEgret LSM module
Thread-Topic: [RFC v3 0/2] WhiteEgret LSM module
Thread-Index: AQHTyAJOnQ+9r2edhk+NYvbIB0nAd6PsWl+AgAVlmJCABVLegIAHHUDQ
Date: Fri, 13 Apr 2018 04:30:30 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2184E8C11A5DEDA145A3B40E92B30@OSBPR01MB2184.jpnprd01.prod.outlook.com>
References: <20180330083031.2199-1-masanobu2.koike@toshiba.co.jp>
 <20180401200827.GA28101@mail.hallyn.com>
 <OSBPR01MB21847D1D8A8BC8458CBAD39592BB0@OSBPR01MB2184.jpnprd01.prod.outlook.com>
 <20180408155114.GE9715@mail.hallyn.com>
In-Reply-To: <20180408155114.GE9715@mail.hallyn.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinya1.takumi@toshiba.co.jp;
x-originating-ip: [103.91.184.161]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB1925;7:IpIPNoG6TuiTrB5m3dHY3YW0h3Lxvhs5sMDEr5/OjULiuTsujy24yD2yX2g0RSmvk6DwC1mhsTP0Fyto+OsR1QoOM/wKkvLp6wwkOQcqrOwu7sl5mAeUas4h1LGTOWLjiR4b/5Rz9qOcPp3v83y2ndBg/i6sCuSazI08rjQ8aVKWiICsu3+qGmozNm7rFyoxIIqOVoVkxpEdNFeXzROMwpiaqb1SKT76dKbHnoovFhZ5ej39YZWScUBlSJi56yh6
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB1925;
x-ms-traffictypediagnostic: OSBPR01MB1925:
x-microsoft-antispam-prvs: <OSBPR01MB19255B08722EDBCA6DD44DA392B30@OSBPR01MB1925.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501327)(52105095)(3002001)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:OSBPR01MB1925;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB1925;
x-forefront-prvs: 0641678E68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(39380400002)(376002)(396003)(189003)(199004)(13464003)(486006)(66066001)(3280700002)(2906002)(74316002)(6436002)(105586002)(55016002)(97736004)(9686003)(476003)(54906003)(229853002)(6916009)(25786009)(5250100002)(316002)(102836004)(86362001)(3660700001)(4326008)(305945005)(93886005)(33656002)(99286004)(59450400001)(186003)(14454004)(106356001)(74482002)(76176011)(26005)(7736002)(6246003)(5660300001)(53936002)(2900100001)(478600001)(81166006)(81156014)(8676002)(3846002)(6116002)(8936002)(11346002)(7696005)(446003)(6506007)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:OSBPR01MB1925;H:OSBPR01MB2184.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: rVXIBxum50xcH3Zm+zth6T+MgcEwmhpM6XNgnlpiRFofb5UnP3yBFVrzF5iDpoUEmv55Cv708oHF4yHRbeXqJx0ynCRend4yKUtlZIGMXUaGygT/ec909IiUfpvz9dfHIvV/fg0zXXgxqVNT82E//jVPjsD1K8lRqHaredaUzEUdDmQDQiWnGsWr9LK3EDEC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8d9c3a34-3d3e-4458-d943-08d5a0f74a1a
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9c3a34-3d3e-4458-d943-08d5a0f74a1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2018 04:30:30.2495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1925
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3D4UtqU015467

> Do you have a target date for posting that?
Yes, we have the target date. We will submit WhiteEgret v4 by September.

> So you have a design for being able to differentiate the interpreters 
> reading versus reading with the intent to execute?
> With or without their help?
We will provide WEUA sample to be able to control a script program with WhiteEgret v4.
Our WEUA sample does not identify whether to read or to read with the intent to execute. 
The sample has some restrictions.

We consider that the restrictions can be resolved by implementing additional functions for WEUA.
It is an implementation-dependent matter.

Howerver, we are sure that the restrictions are acceptable for many applications.
We would like to discuss about them with WhiteEgret v4 patch!

-----Original Message-----
> I am one of developers of WhiteEgret.
> 
> > regardling the last one, do you have a plan for handling it?
> Yes, we have a plan to release WhiteEgret v4 patch with a WEUA sample of access control for script programs.

Do you have a target date for posting that?

> The latest WhiteEgret cannot control script programs since script files read by an interpreter are not hooked by the execve system call.
> We consider that script programs can be controlled by controlling the files inputted by interpreters, accordingly. 
> We consider that the control can be realized using the read system call hooking.

So you have a design for being able to differentiate the interpreters reading versus reading with the intent to execute?  With or without their help?

> Now, we are developing WhiteEgret with the read system call hooking and WEUA which controls the script files to be read to interpreters using information from the read system call hooking and white list.

-serge
