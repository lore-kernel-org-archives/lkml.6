Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751722AbeEUOOt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 10:14:49 -0400
Received: from mail-ve1eur01on0056.outbound.protection.outlook.com ([104.47.1.56]:30272
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751039AbeEUOOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 10:14:48 -0400
From: "Ofer Levi(SW)" <oferle@mellanox.com>
To: "vgupta@synopsys.com" <vgupta@synopsys.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Meir Lichtinger" <meirl@mellanox.com>
Subject: RE: ARC compact700 NPS platform - EZ_MachineCheck exception handler
Thread-Topic: ARC compact700 NPS platform - EZ_MachineCheck exception handler
Thread-Index: AdPxAFKCVPWfnmkrQ+CoZqjBzcAhqAADIrHA
Date: Mon, 21 May 2018 14:14:38 +0000
Message-ID: <DB6PR05MB4597A3B8BC5BE80BD039B0AAB2950@DB6PR05MB4597.eurprd05.prod.outlook.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oferle@mellanox.com;
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR05MB3416;7:C3x+MZ4fvhYQMr4gaAns62i7fBLQbUM47FOttTVDKpw1ysmQ/zDr0qQramFHBRZB9PrMBFln1rfNdYAlxD4tgBy19AoHg1/veYfgbPuRe8GoNsiywUA0LRy+o5iZ15/gYIZUe4o4fTWm7Ku0RWRkkp22U3cyzPij39FLurJSxAXIHdea82eVX4nHDBJH4xjkf+R7R39SmoWiiuYMdeUVh/1REmIs+qyDZbl0YMJIa4/9cdqRV0UQk5EHU8L4kl4d
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB3416;
x-ms-traffictypediagnostic: DB6PR05MB3416:
x-microsoft-antispam-prvs: <DB6PR05MB3416170A7898ED7AE7699B16B2950@DB6PR05MB3416.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR05MB3416;BCL:0;PCL:0;RULEID:;SRVR:DB6PR05MB3416;
x-forefront-prvs: 06793E740F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39380400002)(366004)(396003)(39860400002)(376002)(52544003)(189003)(199004)(106356001)(105586002)(25786009)(7736002)(2906002)(305945005)(74316002)(81156014)(14454004)(2501003)(478600001)(26005)(6506007)(1730700003)(2351001)(102836004)(186003)(97736004)(81166006)(8936002)(107886003)(229853002)(7696005)(6246003)(3280700002)(68736007)(5660300001)(8676002)(4326008)(3660700001)(55016002)(6916009)(33656002)(53936002)(5250100002)(9686003)(59450400001)(316002)(86362001)(54906003)(476003)(6116002)(99286004)(5640700003)(66066001)(6436002)(486006)(3846002)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB3416;H:DB6PR05MB4597.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: zj708KqO0EzsolFRn3D7hzK1OvI6Ne1xL8PSV8NcXjosO8PJoPVNV8bYNtx2cBe+eeywr7QDMkivQGOA4B3BDtUqIwTcVouWBrn/8OdA0wxN+apMTnLC/Xgm2PBQOfB2Rc26ysujahwLyR/ZKlcW6Y7T+H3jK8ZSW/s4qPZkUrUtBI4Idz1jplsnwZp2QGsi
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 2c0a02fb-27d3-45ed-18f0-08d5bf253061
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0a02fb-27d3-45ed-18f0-08d5bf253061
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2018 14:14:38.8220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB3416
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4LEEtqP011771

Resending, due to typo in LKML mail  address.


 Hi Vineet,
 
 The EV_MachineCheck exception handler is halting the core for exceptions
 which are not tlb_overlap_fault.
 Since for the NPS platform each core is running a single thread in ZOL (Zero
 Overhead Linux) isolation mode, we feel that most of the time it is safe to
 resume execution instead of halting the core.
 I would appreciate it if you could review the change  below and let me know
 what you think, if this change is valid or if we missed or overlooked
 something.
 We are not looking to push this change upstream, but will be used on some
 systems.
 
 Please see below our implementation after label 1.
 
 Thanks
 Ofer
 
 ENTRY(EV_MachineCheck)
 
 	EXCEPTION_PROLOGUE
 
 #ifdef CONFIG_CONTEXT_TRACKING
 	bl context_tracking_user_exit
 #endif
 
 	lr  r2, [ecr]
 	lr  r0, [efa]
 	mov r1, sp
 
 	; hardware auto-disables MMU, re-enable it to allow kernel vaddr
 	; access for say stack unwinding of modules for crash dumps
 	lr r3, [ARC_REG_PID]
 	or r3, r3, MMU_ENABLE
 	sr r3, [ARC_REG_PID]
 
 	lsr  	r3, r2, 8
 	bmsk 	r3, r3, 7
 	brne    r3, ECR_C_MCHK_DUP_TLB, 1f
 
 	bl      do_tlb_overlap_fault
 	b       ret_from_exception
 
 1:
 	FAKE_RET_FROM_EXCPN
 	bl		do_machine_check  ; using DO_ERROR_INFO macro
 	b       ret_from_exception
 
 END(EV_MachineCheck)
