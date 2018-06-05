Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbeFEO1f (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:27:35 -0400
Received: from mail-sn1nam01on0045.outbound.protection.outlook.com ([104.47.32.45]:35989
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751967AbeFEO1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:27:33 -0400
From: "Hurwitz, Sherry" <sherry.hurwitz@amd.com>
To: Rudolf Marek <r.marek@assembler.cz>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Ivan Ivanov <qmastery16@gmail.com>
CC: Josh Boyer <jwboyer@kernel.org>,
        Linux Firmware <linux-firmware@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Grimm, Jon" <Jon.Grimm@amd.com>
Subject: RE: [PATCH 1/1] Update AMD cpu microcode for family 15h
Thread-Topic: [PATCH 1/1] Update AMD cpu microcode for family 15h
Thread-Index: AQHT88wjL5oKc70JtkGw+Ls62le+yaRAWycAgAf+yQCAAhVRgIAGHTOAgAE8h/A=
Date: Tue, 5 Jun 2018 14:27:27 +0000
Message-ID: <MWHPR1201MB2526CF0F174938EA64156AE98B660@MWHPR1201MB2526.namprd12.prod.outlook.com>
References: <1527213479-121361-1-git-send-email-sherry.hurwitz@amd.com>
 <CA+5PVA7aPRHk=kfxsmPi-qStKEnK_HJ=rTjvtQGO1QbnLb9qBw@mail.gmail.com>
 <CAAaskFAGRUU3APZbsY2w9hW9jbBJfeMbHt8ttg7vXHidp025=g@mail.gmail.com>
 <20180531220503.2jqs3oiqsnw7ye2t@khazad-dum.debian.net>
 <6402a30f-04d3-59d9-92df-5a43e2060f5c@assembler.cz>
In-Reply-To: <6402a30f-04d3-59d9-92df-5a43e2060f5c@assembler.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sherry.hurwitz@amd.com;
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR1201MB0239;7:o0mGmZlfCjtQzugLiyjQ0hIlEDUpc9QGL9G24Fi6QicDEq/gYA5KXjRjie0ph2b9Mi53ixHwzZ34JbTFkMmlYUIHUXtK5fx6BeqWea0d+M9N+mXE7T9XIPypRc6D3O93UYpsgOHnhkiDXPPkN1Zj036Clfzlu65FMjBzxzYERNpIQKEtRUJgjxe/gL3376YJw28t342ZbOE3o9UBNFrq1MivP0ve9jEDYnWFqzJD9SMwsA7DWm+71sWbP8EpGcPB;20:s373HubqlUak4r8VaZkD9B0UEN/C+gNWzFsvHeuKuF7xkAhCHkMaPOgLE0Pe+ohvT6nKd0yO1H0AeTAeH+yHxq0Hpe+ywaFnHST/0CY3yhSvewr2JXGxQzoaJxy6BGDZz7vqPcmf7VKsyKZMOS1cUU4Z6m2q1J962iyTmdb9RnjTRXZQij7yGj57SFeFrpMBMM8Ly5SkJ6wIHZw5bXtwGjm1Zpj6eEnZ1wkMsXE5JTxaxjlzIL01JrRUMZS0njkZ
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(13464003)(189003)(199004)(110136005)(39060400002)(102836004)(6506007)(53546011)(59450400001)(446003)(54906003)(476003)(11346002)(14454004)(345774005)(4326008)(478600001)(105586002)(26005)(33656002)(2906002)(25786009)(3660700001)(316002)(966005)(486006)(8936002)(81166006)(8676002)(7736002)(186003)(305945005)(74316002)(93886005)(68736007)(106356001)(97736004)(5250100002)(9686003)(2900100001)(229853002)(6436002)(15650500001)(99286004)(6116002)(53936002)(3280700002)(55016002)(76176011)(3846002)(6246003)(5660300001)(86362001)(6306002)(7696005)(66066001)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0239;H:MWHPR1201MB2526.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR1201MB0239;
x-ms-traffictypediagnostic: MWHPR1201MB0239:
x-microsoft-antispam-prvs: <MWHPR1201MB023930CB671B2D1A451DD4868B660@MWHPR1201MB0239.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(767451399110)(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR1201MB0239;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB0239;
x-forefront-prvs: 0694C54398
x-microsoft-antispam-message-info: inWAS3VVMw+IPOliHhG62ghVktnYRY3Hj33U7bIqxPrxpNtzX1D5Yu+Te235S+D/vNrkRGstKvikyS6UNlspePHazMjAW4irg3TXPG1FZ9qUnBJlXclkyW9Jz/nS7Ff4JmDSQSTG81HfNBbrtWgE9NZxs6BggEOz8e+w5ogS7p++7pcYrV1COUHsdRRQwTtI
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6a548208-5200-482e-4b8b-08d5caf076dc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a548208-5200-482e-4b8b-08d5caf076dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2018 14:27:27.6653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0239
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w55ERgek016611

Hi Rudolf,
I have been investigating the status with the AMD release management, but I have not been given approval to publish any other microcode.  I have been trying to track down why there might be a version in the wild that I have not been given for public publishing.  It might have come from a BIOS update and not a OS microcode load but I don't have the definitive details on that either.  I will publish whatever is released to me as soon as possible.

Sherry

> -----Original Message-----
> From: Rudolf Marek [mailto:r.marek@assembler.cz]
> Sent: Monday, June 04, 2018 2:27 PM
> To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>; Ivan Ivanov
> <qmastery16@gmail.com>
> Cc: Josh Boyer <jwboyer@kernel.org>; Hurwitz, Sherry
> <sherry.hurwitz@amd.com>; Linux Firmware <linux-firmware@kernel.org>;
> Linux-Kernel@Vger. Kernel. Org <linux-kernel@vger.kernel.org>;
> Suthikulpanit, Suravee <Suravee.Suthikulpanit@amd.com>; Lendacky,
> Thomas <Thomas.Lendacky@amd.com>; Grimm, Jon
> <Jon.Grimm@amd.com>
> Subject: Re: [PATCH 1/1] Update AMD cpu microcode for family 15h
> 
> Hi Sherry,
> 
> Any news on this please? It seems we still miss updated microcode for certain
> fam15h/16h for Linux.
> 
> Thanks
> Rudolf
> 
> 
> Dne 1.6.2018 v 00:05 Henrique de Moraes Holschuh napsal(a):
> > On Wed, 30 May 2018, Ivan Ivanov wrote:
> >> This is still not addressing the outdated 15h microcode version issue
> >> that Rudolf Marek has pointed out. Also, we still hope to see an
> >> updated microcode for 16h architecture as well - it has not received
> >> any updates for two years already
> >
> > True, but now at least it won't regress old boxes anymore, so we can
> > ship it in the stable branches of the distros with less restrictions.
> >
> > It would be really good to be able to actually mitigate spectre v2/v4
> > on most AMD systems, though.  And current experience shows this is
> > only going to happen if we can have the required microcode update also
> > going through the operating system update channels.
> 
> 
> 
> > Dne 24.5.2018 v 16:48 Hurwitz, Sherry napsal(a):
> >> Thank you for pointing this out.  Let me investigate and send out an
> updated fam15h container.
> >
> > Thanks I have seen the patch. However it still contains "old"
> > microcode from 2012, patch level 0x06001119. Do you plan to update it to
> 0x0600111f, which will support IBPB?
> >
> > Thanks
> > Rudolf
> >
> >
> 
> > I noticed in commit [1], that 0x00610f01 microcode is removed
> > completely. It has only entry in the equivalence table, but the actual
> microcode is gone. As this update fixes important errata (and it was latest
> supported microcode officially released), what is the reason behind that?
> >
> > Maybe it is a mistake? Or new microcode will be provided? I seen in
> > the wild one with patch level 0x0600111f, but it does not seem to be
> available?
> >
> > Please can someone throw some light on that?
> >
> > Many thanks
> > Rudolf
> >
> >
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmwar
> > e.git/commit/amd-
> ucode/microcode_amd_fam15h.bin?id=77101513943ef198e20
> > 50667c87abf19e6cbb1d8
