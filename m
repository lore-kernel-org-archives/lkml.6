Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeFDIdu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:33:50 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:6383 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbeFDIds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:33:48 -0400
X-IronPort-AV: E=Sophos;i="5.49,476,1520870400";
   d="scan'208";a="176440266"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
CC: "gwendal@chromium.org" <gwendal@chromium.org>
Subject: Re: [PATCH 3/7] scsi: ufs: Make sysfs attributes writable
Thread-Topic: [PATCH 3/7] scsi: ufs: Make sysfs attributes writable
Thread-Index: AQHT93lxdbMqTFIZiEmNL0mhgS6N8aRPzowA
Date: Mon, 4 Jun 2018 08:33:46 +0000
Message-ID: <bde08554b8939de962a88068bb132ab320f8f7a5.camel@wdc.com>
References: <20180529181740.195362-1-evgreen@chromium.org>
         <20180529181740.195362-4-evgreen@chromium.org>
In-Reply-To: <20180529181740.195362-4-evgreen@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [178.117.55.239]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0431;7:0TLDbgFuN21dx+QfN8t5HGyMaNKqYVcUcCnjfGj30U4u3p4oMoDHJXXnjRESWw2J6/5cMtFSotIXqJNju4yJ6wstPUpiJciJKC55djuMEox+SxB6rtdsHHY+stbeZBpXhYXN1YdaVf924DEW1f4E6hpG3LDuLC5cvKhEgtXddNECLLCL4oxrvehvsjdlFqXmbN4eg6zrfIQWoGc4vg9M+ZguJmA4bzwU2oABp7ypkA9Fs5Pil5/gz+K89iF3RudW;20:SByUySkreHq4Me6uFvaQl3Yl8/V+meMyTqu1IEcB/pUpP9FEKjNRqj5ibRPHHMupDdrcEN6w0qf5cypE+d2rAB2+r73OFDsD/yiRjtH9Y8f+cnJYN/oPa6NRpmEqUZk7zcj679dfunFdfSBa2MLr2mGZWumYOd+hJTK8w0Y/Uvk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0431;
x-ms-traffictypediagnostic: MWHPR04MB0431:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0431DD67568BE9184574949698670@MWHPR04MB0431.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0431;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0431;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(376002)(346002)(39860400002)(199004)(189003)(478600001)(53936002)(11346002)(6636002)(8936002)(2616005)(476003)(446003)(110136005)(6246003)(186003)(3660700001)(25786009)(6116002)(2900100001)(7736002)(305945005)(118296001)(3846002)(14454004)(6506007)(26005)(72206003)(5660300001)(3280700002)(316002)(66066001)(486006)(6512007)(2501003)(99286004)(6436002)(102836004)(97736004)(5250100002)(105586002)(86362001)(2201001)(6486002)(36756003)(2906002)(8676002)(76176011)(39060400002)(81166006)(81156014)(229853002)(4326008)(68736007)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0431;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 0lOCLWlbmWRvGSItWfbSyAbSFCsM22Q17lHpMgulOLplM0haNkva8Z3dhd/ItGCY64WkDAcNmOZlOTtnbJTveKIT6xEpqPw+Kcsd5L5y4TS/bAFcssw/SlXwi7+8riJZQYAouhBjEiIz3k4lmNhW6WU2FMQg0RczO9Jpn7Ksz3bXKLf66RdcLeLMtVIS7ROB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEF956B827C5824C95AB3AA65B7ADB41@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c232f278-04f1-4698-63a7-08d5c9f5e3b6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c232f278-04f1-4698-63a7-08d5c9f5e3b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 08:33:46.6094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0431
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w548XuJD028696

On Tue, 2018-05-29 at 11:17 -0700, Evan Green wrote:
> +static ssize_t _name##_store(struct device *dev,			\
> +		struct device_attribute *attr, const char *buf,		\
> +		size_t count)						\
> +{									\
> +	struct ufs_hba *hba = dev_get_drvdata(dev);			\
> +	unsigned long value;						\
> +	if (kstrtoul(buf, 0, &value))					\
> +		return -EINVAL;						\
> +	if (ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,	\
> +		QUERY_ATTR_IDN##_uname, 0, 0, (u32 *)&value))		\
> +		return -EINVAL;						\
> +	return count;							\
> +}									\

Casting an "unsigned long" pointer into an u32 pointer looks evil to me.
Please don't do this.

Thanks,

Bart.
