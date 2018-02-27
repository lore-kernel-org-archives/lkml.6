Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbeB0RGG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 12:06:06 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:48405 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbeB0RGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 12:06:03 -0500
X-IronPort-AV: E=Sophos;i="5.47,401,1515427200";
   d="scan'208";a="72452179"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: core: fix two wrong indentation cases
Thread-Topic: [PATCH] scsi: core: fix two wrong indentation cases
Thread-Index: AQHTrte9BFEitrgcKEynRSENzkXo+KO4fMkA
Date: Tue, 27 Feb 2018 17:05:59 +0000
Message-ID: <1519751158.23791.2.camel@wdc.com>
References: <1519631956-1775-1-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1519631956-1775-1-git-send-email-jianchao.w.wang@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0401MB1676;7:dWkSVp51ynQCB4ycUJx+sol6dNBa2HLTkKD5BZZJQ8Rxy0HlybES+sn1FaFmSGYI17sO0vSqUku28d7fcr3wN0IwyzbviKwRo1kmIlVAc+X4n2HMsAWL1LKh0kLgwXkR+ZiniSeku70gj60YKQZiOUwLm/+nufv5SwKwbx+k3cSuGWL1aJAOhakN9u3X2pTGN6lHS9aOp55/AF06lp6BBhJkbO4i0WB4+ucS5KskJ/a0FWPqCuk4vwz953Ibikrq;20:SHjHE79wUgP1FZpW4Xxi3d+vJ43xu2e12Hq/l1uwkQHVENIRW6q+GlQx7yNvOq1gWxC6IVvHFuEA8pOyuBdRhNDujW25p/rB3lUakwruAqaayr7JouUk+43vLIc1cUxaTF/Qm8mGhsO0laBs9yFDV3006p4V24cFcrVcw6xpTg0=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd3bc520-db62-48cd-9470-08d57e045faf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:CY1PR0401MB1676;
x-ms-traffictypediagnostic: CY1PR0401MB1676:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR0401MB1676206C7FF69B69AEBF697D98C00@CY1PR0401MB1676.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(3231220)(944501198)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:CY1PR0401MB1676;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0401MB1676;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(396003)(376002)(39380400002)(199004)(189003)(377424004)(6436002)(102836004)(68736007)(106356001)(478600001)(66066001)(558084003)(103116003)(2501003)(76176011)(5660300001)(6506007)(3280700002)(25786009)(105586002)(3846002)(6116002)(72206003)(77096007)(2906002)(6246003)(4326008)(110136005)(54906003)(6512007)(2900100001)(186003)(229853002)(99286004)(8936002)(3660700001)(53936002)(305945005)(36756003)(7736002)(26005)(97736004)(8676002)(2950100002)(2201001)(14454004)(6486002)(316002)(81156014)(86362001)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0401MB1676;H:CY1PR0401MB1536.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: NGDE9N2IbDAwzjrvUTffDN9j1d+jyllge7sG8JAGHdb3+HSjFkDpJL3ajJY8Jc1Fh7hceyJwUP5MLAD2AlPohH/akSsbZlZ15LkGLRVMPXf69uHO2zAfLS6qboQ9pxkt6e/m/wPv+hP1QoLX8dDFyLANOwQDmX8r8CH/Sc6DZPM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BFD36AA7CDE2146BF6F60C7E7A170A0@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3bc520-db62-48cd-9470-08d57e045faf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 17:05:59.2479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0401MB1676
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1RH6DQI021130

On Mon, 2018-02-26 at 15:59 +0800, Jianchao Wang wrote:
> No functional changes. Just fix two wrong indentation cases in
> scsi_finish_command and scsi_decide_disposition.

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
