Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbeDFCUN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 22:20:13 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:59576 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeDFCUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 22:20:11 -0400
X-IronPort-AV: E=Sophos;i="5.48,413,1517846400";
   d="scan'208";a="76011558"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "wakko@animx.eu.org" <wakko@animx.eu.org>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: 4.15.14 crash with iscsi target and dvd
Thread-Topic: 4.15.14 crash with iscsi target and dvd
Thread-Index: AQHTyTSBb5uvLpZh0kGvcKoLkXFdJKPq6GkAgABbqICAAIUdgIAAU3eAgAAfGYCAAw0ygIADtuOAgAAFnoCAAAO2AA==
Date: Fri, 6 Apr 2018 02:20:09 +0000
Message-ID: <fb0640c203409a84ab1bfbbc41078a5416138ad2.camel@wdc.com>
References: <20180331015903.GA29398@animx.eu.org>
         <CAFLxGvzbA9XzXLsH56iyqYkitrSnBbOzD977u4266=w5zw0jNg@mail.gmail.com>
         <20180331221252.GA25573@animx.eu.org>
         <b68bf187c9cde1c36489fc5ab2187ca8750a1292.camel@wdc.com>
         <20180401113721.GA8471@animx.eu.org> <20180401163604.GB25011@animx.eu.org>
         <20180401182723.GA31755@animx.eu.org>
         <595a10cfb387e6b2ab4d2053b84fed9b3da9e079.camel@wdc.com>
         <20180406014644.GA16112@animx.eu.org> <20180406020651.GB16112@animx.eu.org>
In-Reply-To: <20180406020651.GB16112@animx.eu.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [76.103.131.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR04MB1030;7:HfPHpd3ojOzJ46rs1AbETjODbtub1SO5X+SWRcjuPHeDr99Yw3QGQbfnbjamhPCPR4/srv5v574OwODCz59poeEdVdBYKT07V8I8GcFs7zsTIU1uRHKfX+yvVb/BKc4VIFo41OiG1qIZaJjkgar8hbe9aPF731UJmM5nKDHxVHkAGsN38DqdvhA43RJdlksP7pyhGLPeyyY8gJjuZ9WSLg9uHxkVC5OsFmiCVb/xi903uApeXY8J5JD7mPJKLkce;20:WA6y7qVVWgGcRkKEhYa72xzsQ37I5b2A/sqLPlCj6EKIXckwv2Yk816sr6KWQhyttvWZdhpz5Cyygd+pVVlbeQPNTp3TeY6wv6CfvRREsILKltDA4I85YsZ9i/ShDhCyPyPBqmOP8fKiUlTa0hyYXUgmDQLP+X8mIud97d4OZYA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 983a089f-161f-4790-177b-08d59b64ebb7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR04MB1030;
x-ms-traffictypediagnostic: CY4PR04MB1030:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY4PR04MB1030AC592204C37115853F0B98BA0@CY4PR04MB1030.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR04MB1030;BCL:0;PCL:0;RULEID:;SRVR:CY4PR04MB1030;
x-forefront-prvs: 0634F37BFF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39840400004)(366004)(39380400002)(377424004)(189003)(199004)(478600001)(5640700003)(2906002)(39060400002)(6916009)(105586002)(5660300001)(3846002)(6116002)(7736002)(305945005)(6246003)(99286004)(72206003)(118296001)(2900100001)(68736007)(966005)(4326008)(86362001)(106356001)(25786009)(102836004)(97736004)(76176011)(186003)(316002)(26005)(229853002)(36756003)(11346002)(446003)(476003)(66066001)(2501003)(2616005)(5250100002)(486006)(6506007)(54906003)(93886005)(53936002)(3660700001)(8936002)(6436002)(3280700002)(6486002)(1730700003)(6306002)(6512007)(8676002)(81166006)(81156014)(14454004)(2351001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR04MB1030;H:CY4PR04MB1191.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 03POVLNR2N8DJXNgUeOoftxhJZHLOi46PUOYUVM+nggHludFOkvjpCPvSmA/2IR2LHYhZlh3aHhCmUrDShA25TCjjY248WrZQpEDxPZcbXqNdlpWELk8evJLvE4KERB1zkKEetw1bEX3OfrJKsDqzLdZDJKeNqysZvel2DfWLpRs1IU5WYWSPx/HJTDSvtcwcoKaH0GarNI3o/R2ShoWu48+jLEh7a+4agI69rxfj4qAJHDdII1mYwN9PdFu7PRGfX+8IxpM5g19oMZTyncWT6uckLJlRB9VrDYH636WmeNOLnnGT0sLB1EsFXO5be6e24fiCcTacpwOSr7nCVgQzEMIx2bAPgB+LoHUyaWrhS/ZFM/TL5WmVImS1IZGiMAedA2zSecMWINyFqNsqJr9iMO02Lk3mT1A5j9bzL2kAVY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA83534AC125D942A0DD10C689F57199@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983a089f-161f-4790-177b-08d59b64ebb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2018 02:20:09.5066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1030
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w362KHn7007471

On Thu, 2018-04-05 at 22:06 -0400, Wakko Warner wrote:
> I know now why scsi_print_command isn't doing anything.  cmd->cmnd is null.
> I added a dev_printk in scsi_print_command where the 2 if statements return.
> Logs:
> [  29.866415] sr 3:0:0:0: cmd->cmnd is NULL

That's something that should never happen. As one can see in
scsi_setup_scsi_cmnd() and scsi_setup_fs_cmnd() both functions initialize
that pointer. Since I have not yet been able to reproduce myself what you
reported, would it be possible for you to bisect this issue? You will need
to follow something like the following procedure (see also
https://git-scm.com/docs/git-bisect):

git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git bisect start
git bisect bad v4.10
git bisect good v4.9

and then build the kernel, install it, boot the kernel and test it.
Depending on the result, run either git bisect bad or git bisect good and
keep going until git bisect comes to a conclusion. This can take an hour or
more.

Bart.
