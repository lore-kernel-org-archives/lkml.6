Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbeDGCGo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 22:06:44 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:48380 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeDGCGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 22:06:42 -0400
X-IronPort-AV: E=Sophos;i="5.48,417,1517846400";
   d="scan'208";a="75443712"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "wakko@animx.eu.org" <wakko@animx.eu.org>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: 4.15.14 crash with iscsi target and dvd
Thread-Topic: 4.15.14 crash with iscsi target and dvd
Thread-Index: AQHTyTSBb5uvLpZh0kGvcKoLkXFdJKPq6GkAgABbqICAAIUdgIAAU3eAgAAfGYCAAw0ygIADtuOAgAAFnoCAAAO2AIABfPAAgAARnwA=
Date: Sat, 7 Apr 2018 02:06:39 +0000
Message-ID: <a631d319b0123a0f90b68e44a7df19dffb253751.camel@wdc.com>
References: <CAFLxGvzbA9XzXLsH56iyqYkitrSnBbOzD977u4266=w5zw0jNg@mail.gmail.com>
         <20180331221252.GA25573@animx.eu.org>
         <b68bf187c9cde1c36489fc5ab2187ca8750a1292.camel@wdc.com>
         <20180401113721.GA8471@animx.eu.org> <20180401163604.GB25011@animx.eu.org>
         <20180401182723.GA31755@animx.eu.org>
         <595a10cfb387e6b2ab4d2053b84fed9b3da9e079.camel@wdc.com>
         <20180406014644.GA16112@animx.eu.org> <20180406020651.GB16112@animx.eu.org>
         <fb0640c203409a84ab1bfbbc41078a5416138ad2.camel@wdc.com>
         <20180407010334.GA11092@animx.eu.org>
In-Reply-To: <20180407010334.GA11092@animx.eu.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [76.103.131.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0751;7:fa2UYwQKhUI6ohR19HSavvMNTEu3YNU5QU1r+eIVpzcUOpqvsjLVDRoZC1bfHo7jy3HZwwWEvLE8zlpzGwCbLUoHQB1eOvAeClwZTmU3DbXXYE43JdUG1DPWYBk/H0M3csQgcKgVgsrAnS4F7W4I0GCNn17vgDXBP3vSR+akeuPJETrilor+GAJTcEEMd+WohC6OGYJSYAUSFNMdgveOA2Dz8FrzRKVbPsk+H5NWMJzb7NN58TengScbxqCgnUCr;20:NpvezubQnKwMQqc3E6zHWDpmQKTzSy2tWhHr6nwTpuVOlrKORilvSyq0gGzi7CiWCLVkiS7OBw4T69BFRLDfrpfRCxANSwHHRMqMEejqrfZmvUhLcGJQTys9NnlCjywz7lFQm6Q7F7uBP91yuRyNhxFhsAyG6icN+GXbOk7Hado=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1fbf9918-1255-44b0-983c-08d59c2c333c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0751;
x-ms-traffictypediagnostic: MWHPR04MB0751:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0751405F09BC93B6F64CA1BF98B90@MWHPR04MB0751.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR04MB0751;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0751;
x-forefront-prvs: 0635D5275E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(39380400002)(396003)(346002)(189003)(199004)(377424004)(2900100001)(3660700001)(5660300001)(76176011)(66066001)(7736002)(93886005)(3280700002)(2351001)(14454004)(4326008)(97736004)(72206003)(2616005)(2501003)(86362001)(486006)(305945005)(36756003)(118296001)(966005)(68736007)(5250100002)(6306002)(229853002)(99286004)(11346002)(25786009)(6512007)(446003)(6506007)(6436002)(476003)(6486002)(39060400002)(6916009)(8936002)(81156014)(186003)(8676002)(105586002)(53936002)(5640700003)(2906002)(81166006)(6246003)(26005)(106356001)(478600001)(316002)(102836004)(3846002)(1730700003)(6116002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0751;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: +knNDGA6NSSkri/FRHBu3WQ6eGwv5S0DPzJlo4FlA0B7mDlzelirchugGu8h0pwbkw1eWed0xfoL9ZOPvQ4FfJh1QJ9hlmN2Jea2+qM/ZWh/RWp3PWHLQjA+EOIvyJCKFq/MIEJk/UKAavlzI98tI7XffwvLjMjrGZgQoZXb5TL8mpv+AD5luONgy/AYdS+VNYOu39E7/HMpQTyKFg8lm7m6MdFIYCDBvoaB8gw2gwuYaxIg420ILQT5I1AYVKvTjtjYTbpjk/Qv+NpwSQ6e2kCx4dT91mgJCOyIFu2UbjcAoz5VOLLXKLDlouJMjMlb0cvuVZaAF4nkqnXM41jdS6oLgrqUT3G9AEomIxt7VEG8NY1L5KhDDVQOIhMPvJtUR3Syp68BL77cgf73BbCiXHr4SLJ6WdmagtbTiRxauIU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1273440D4C884042A0676C85A025C9AE@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbf9918-1255-44b0-983c-08d59c2c333c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2018 02:06:39.3021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0751
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3726wNo019080

On Fri, 2018-04-06 at 21:03 -0400, Wakko Warner wrote:
> Bart Van Assche wrote:
> > On Thu, 2018-04-05 at 22:06 -0400, Wakko Warner wrote:
> > > I know now why scsi_print_command isn't doing anything.  cmd->cmnd is null.
> > > I added a dev_printk in scsi_print_command where the 2 if statements return.
> > > Logs:
> > > [  29.866415] sr 3:0:0:0: cmd->cmnd is NULL
> > 
> > That's something that should never happen. As one can see in
> > scsi_setup_scsi_cmnd() and scsi_setup_fs_cmnd() both functions initialize
> > that pointer. Since I have not yet been able to reproduce myself what you
> > reported, would it be possible for you to bisect this issue? You will need
> > to follow something like the following procedure (see also
> > https://git-scm.com/docs/git-bisect):
> > 
> > git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > git bisect start
> > git bisect bad v4.10
> > git bisect good v4.9
> > 
> > and then build the kernel, install it, boot the kernel and test it.
> > Depending on the result, run either git bisect bad or git bisect good and
> > keep going until git bisect comes to a conclusion. This can take an hour or
> > more.
> 
> I have 1 question.  Should make clean be done between tests?  My box
> compiles the whole kernel in 2 minutes.

If you trust that the build system will figure out all dependencies then
running make clean is not necessary. Personally I always run make clean
during a bisect before rebuilding the kernel because if a header file has
changed in e.g. the block layer a huge number of files has to be rebuilt
anyway.

Bart.
