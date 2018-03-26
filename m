Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbeCZXAk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 19:00:40 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:9434 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbeCZXAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 19:00:38 -0400
X-IronPort-AV: E=Sophos;i="5.48,365,1517846400";
   d="scan'208";a="74413417"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hare@suse.de" <hare@suse.de>
Subject: Re: [PATCH] scsi: don't look for NULL devices handlers by name
Thread-Topic: [PATCH] scsi: don't look for NULL devices handlers by name
Thread-Index: AQHTwqwduOCmTcOlTUy8WwDRO3c46KPjJySA
Date: Mon, 26 Mar 2018 23:00:35 +0000
Message-ID: <1522105233.3102.32.camel@wdc.com>
References: <20180323133705.14556-1-jthumshirn@suse.de>
In-Reply-To: <20180323133705.14556-1-jthumshirn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1230;7:Q9oySG/B6LuNF9DjvNk8y3AA+b1knUP2/n3pLZ+8clY5v65lhpfe8GWOiiFtfLkIW8/AyO3UYmyFMYGxxRK0b/8oSfCKFM31LKSsUfrTLXfgHOiRuIFnbZs7riaVyq/r9lr1qeRNUTh8DRypEOjQesI7x1UqUD0Aqo+tFnkbIncv+P6hIzx8NaLI+WRpe9t9OwiPI7mo3/IUBQ88NvFrhZPi7x56MUAE1foyqub/Ne1G5SxwZ2mFEA2J6hWXdlB8;20:LSWFlBZMztNW25uBRAV09RXUp0P/0v5su/VUcRWl81+mEUFZTbJ+xduYlyhJ4RCkyqssdT7WNcUZR9MYR3vbjS+lyRbNBLVjrNtztI6dKIojjgynhTGK+hRSoFwRuHYXTjrmr5VDcOlUGKiEF+HKj9a8WHTFKMBV8QocG+rS5cA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48a97643-3aee-4fd2-d519-08d5936d623e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1230;
x-ms-traffictypediagnostic: MWHPR04MB1230:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB123048B11C10640F95EB75E198AD0@MWHPR04MB1230.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR04MB1230;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1230;
x-forefront-prvs: 06237E4555
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39380400002)(39860400002)(376002)(366004)(377424004)(189003)(199004)(229853002)(86362001)(11346002)(99286004)(5660300001)(5250100002)(106356001)(186003)(2906002)(2900100001)(446003)(66066001)(3846002)(76176011)(6246003)(476003)(105586002)(305945005)(7736002)(2616005)(53936002)(6116002)(110136005)(6512007)(8936002)(4326008)(68736007)(97736004)(72206003)(478600001)(54906003)(81156014)(81166006)(8676002)(3660700001)(3280700002)(102836004)(26005)(6436002)(6506007)(103116003)(316002)(36756003)(25786009)(14454004)(486005)(486005)(6486002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1230;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: j7ZduvTO9DxnO1nfTFMQQ9h2IeddfdGpOzjfalvEZE+Ap9YlgdI+uJdhBQ0dS2eT0Gg0TBeG5tDvR90up3+biwC1xY5hYTboHh/VW5Qs4/xEODlXM8FVnUfSyZhrpjsgITu7Y3vXHTy1CFXXVcph4wTgKljvSIA/EzXUi3RijgA3bloHgIjrt6FbsBmsgfLTE2+SDfznLKSXsLFNw16pudAnDO4KuuyKvFVQP19BjOhaIG2I9yfWWNP2r/3470sruIOPd72L7NMz0eG9H7G8L/w2euA3pCIPSCNXnVEan4JC74LVQrP3bG57DvBFUdgUfkUXaTSiyGCpwGqJJNwesA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFECD33C6A633942ACE05279A4655E5B@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a97643-3aee-4fd2-d519-08d5936d623e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2018 23:00:35.0859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1230
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2QN0kOO032532

On Fri, 2018-03-23 at 14:37 +0100, Johannes Thumshirn wrote:
> Currently scsi_dh_lookup() doesn't check for NULL as a device
> name. This combined with nvme over dm-mapth results in the following
> messages emitted by device-mapper:
> 
>  device-mapper: multipath: Could not failover device 259:67: Handler scsi_dh_(null) error 14.
> 
> Let scsi_dh_lookup() fail fast on NULL names.

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
