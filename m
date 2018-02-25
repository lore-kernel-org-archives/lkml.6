Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751851AbeBYRCs (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 12:02:48 -0500
Received: from us-smtp-delivery-194.mimecast.com ([216.205.24.194]:29510 "EHLO
        us-smtp-delivery-194.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751670AbeBYRCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 12:02:45 -0500
From: Trond Myklebust <trondmy@primarydata.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client bugfixes
Thread-Topic: [GIT PULL] Please pull NFS client bugfixes
Thread-Index: AQHTrlpxMyatvmcj3ESYPu8mWrsKUg==
Date: Sun, 25 Feb 2018 17:02:40 +0000
Message-ID: <1519578159.3131.1.camel@primarydata.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [68.49.162.121]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR11MB1578;7:VlxoKLY3KajbYRQ0pbn2lJNVMtU5X/XqBabJa0GBvAv8FbBRBJO74XZRd9llWSmW2xIX7I6sUW+n2Yuy/SyuP6rnVqBq++Fao37IJYoV7DV5zWdrptDE0leIJm63zzWweSL0ZroM6TvHBKL8Iu+kJs/A8DmfSq4OH1ZmEqhS7Cqzlb5jNZKsg+9VlO8ezaGYMLpLlnBs8y//Xmg/cKh/FgkvM1x6vlAyKGBY43dm/GimDscIvMqmeBvMwwH6mfoD;20:B9X+G7J29lPFEayJhWOSEl4smsAlvx+CzoenHEoJxlnYWf8RvpsMLxAwiiZGzre9xqVYDmPOYB+GjEdbLzTa8l8VZ7pVekPL3ONEuQiJBQUkAGYyS405Za1YTY/04psykob6h+BpIIkMfcjlvN+fIJSOERMGyqZwf/oe+lFNnKI=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: f7f24659-f6b9-4862-92fb-08d57c71949b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM5PR11MB1578;
x-ms-traffictypediagnostic: DM5PR11MB1578:
x-microsoft-antispam-prvs: <DM5PR11MB1578BC4CCD0AFEC73D471856BEC20@DM5PR11MB1578.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150)(5213294742642)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501161)(52105095)(93006095)(93001095)(6041288)(20161123564045)(2016111802025)(20161123560045)(20161123562045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:DM5PR11MB1578;BCL:0;PCL:0;RULEID:;SRVR:DM5PR11MB1578;
x-forefront-prvs: 05947791E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(39830400003)(346002)(396003)(199004)(189003)(377424004)(305945005)(5660300001)(6512007)(7736002)(4326008)(6506007)(102836004)(59450400001)(186003)(26005)(106356001)(66066001)(25786009)(5250100002)(2501003)(103116003)(8936002)(6916009)(86362001)(575784001)(8676002)(81166006)(81156014)(1730700003)(2351001)(3660700001)(2906002)(97736004)(105586002)(2900100001)(3280700002)(316002)(68736007)(36756003)(99286004)(3846002)(6116002)(478600001)(54906003)(6436002)(6486002)(5640700003)(14454004)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR11MB1578;H:DM5PR11MB0075.namprd11.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: N7Wa1hRClz3bt/YMHdVAs1A5aUMjKrQ/uB2qEfZYMVOaAcy0BsKl1dcu8pwf4lQhJuAuyxl3XNbFNzWoDxmrjGEhPUzbPpzwr9UyKzFAy2cz/XsVamSKFGkN4B9vyskKdz/iAR8r/z4l3pi9KC08M5Mjg4yqXRPIi0D2h8OXiPY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <14C800145C6425459DB3A607F1E6091D@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: primarydata.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f24659-f6b9-4862-92fb-08d57c71949b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2018 17:02:40.7603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 03193ed6-8726-4bb3-a832-18ab0d28adb7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1578
X-MC-Unique: bChBWZjmOqy_62v9cLteGw-1
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1PH2wiB009613

Hi Linus,

The following changes since commit af3e79d29555b97dd096e2f8e36a0f50213808a8:

  Merge tag 'leds_for-4.16-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds (2018-02-20 10:05:02 -0800)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-4.16-3

for you to fetch changes up to 1b7204064582792b77c6be796e78bd821c9f71b1:

  NFS: make struct nlmclnt_fl_close_lock_ops static (2018-02-22 12:23:01 -0500)

----------------------------------------------------------------
NFS client bugfixes for Linux 4.16

Hightlights include:
- Fix a broken cast in nfs4_callback_recallany()
- Fix an Oops during NFSv4 migration events
- make struct nlmclnt_fl_close_lock_ops static

----------------------------------------------------------------
Bill.Baker@oracle.com (1):
      nfs: system crashes after NFS4ERR_MOVED recovery

Colin Ian King (1):
      NFS: make struct nlmclnt_fl_close_lock_ops static

Trond Myklebust (1):
      NFSv4: Fix broken cast in nfs4_callback_recallany()

 fs/nfs/callback_proc.c | 14 ++++++--------
 fs/nfs/nfs3proc.c      |  2 +-
 fs/nfs/nfs4client.c    |  6 ++++--
 3 files changed, 11 insertions(+), 11 deletions(-)
-- 
Trond Myklebust
Linux NFS client maintainer, PrimaryData
trond.myklebust@primarydata.com
