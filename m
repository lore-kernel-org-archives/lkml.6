Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbeFDIqI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:46:08 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:13944 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbeFDIqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:46:06 -0400
X-IronPort-AV: E=Sophos;i="5.49,476,1520870400";
   d="scan'208";a="176441492"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
CC: "gwendal@chromium.org" <gwendal@chromium.org>
Subject: Re: [PATCH 6/7] scsi: ufs: Enable writing config descriptor
Thread-Topic: [PATCH 6/7] scsi: ufs: Enable writing config descriptor
Thread-Index: AQHT93mP3lZPzfYzAU25mohFXJ7LEKRP0fqA
Date: Mon, 4 Jun 2018 08:46:03 +0000
Message-ID: <6089990e71830e699a9106eaff91e344e1d24c39.camel@wdc.com>
References: <20180529181740.195362-1-evgreen@chromium.org>
         <20180529181740.195362-7-evgreen@chromium.org>
In-Reply-To: <20180529181740.195362-7-evgreen@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [178.117.55.239]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1185;7:vwQhUKiZlOfWKYV16vk1mmUVp4OLV9XBuPR78de+PiMc25AAP9VkOmBsp0ITub/1z2oHDMB8Gx91cV260q3xiEqUAO3kb+OdpXaZCLTWF5/mdvgbak9PvLXxDldSbVodGtBpNU0CCrSGxeqpNbBPvSmjtXBiEVYKx3Ys+txtWkC1UGpU+RFbPBwLb+elV7hCl7wcuBbqZqYV1WLm1lLucJSfEq9qf3CD83X/TP6hS+g4PZMkGfU3PD2jGMw830oV;20:mD3IUwCKEUP9uWMf9ux/vePDwMlMGsUODOujaRn3TXAcVxDf2Xyu0EzUC9VGunaDQ45LUSgF1wpEtCKE5XXKgM7K0x2lpVAveCIjCgGQAukNpzLLRMitlK7iGTyYw5L+bgcOBfcbxrGPGRvDTtQPjVeFugGvRBx00dOX6t83ei4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1185;
x-ms-traffictypediagnostic: MWHPR04MB1185:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB11852D2CFA88BC664EF19D7B98670@MWHPR04MB1185.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB1185;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1185;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39380400002)(366004)(376002)(39860400002)(189003)(199004)(3846002)(6512007)(39060400002)(4326008)(2201001)(25786009)(26005)(5250100002)(8676002)(97736004)(36756003)(53936002)(106356001)(86362001)(118296001)(476003)(6506007)(11346002)(446003)(3280700002)(76176011)(2906002)(2616005)(72206003)(6486002)(68736007)(5660300001)(99286004)(3660700001)(2900100001)(66066001)(478600001)(6436002)(59450400001)(229853002)(14454004)(81166006)(102836004)(305945005)(81156014)(2501003)(316002)(8936002)(7736002)(6116002)(186003)(6636002)(6246003)(110136005)(105586002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1185;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: RFvQeeFxAK2TYA+F2mcyaBWVOWlKt7mjp0uBnffY43MVckjJMVwNC3mGWR9/svuEpECNafcRDrSDhrTrEClyi5RARnB+CH2Bxp1jmwhMa2Yr/vKhDp9A5yJj5sf3UZZJr5oxUwl4bPXbLmmKQK/vLdhuAu3PwRAyKXPQeMbPPjssy5n2jEafZRAmLpdmvB1y
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7822986D20A9A84DBAD47E21E5815180@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3379a7a5-f6d9-448f-f5a9-08d5c9f79aec
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3379a7a5-f6d9-448f-f5a9-08d5c9f79aec
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 08:46:03.4712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1185
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w548kEja028782

On Tue, 2018-05-29 at 11:17 -0700, Evan Green wrote:
> This change enables writing to fields of the config descriptor
> via sysfs. It can be used to provision an unprovisioned UFS
> device, or reprovision an unlocked device.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>  drivers/scsi/ufs/ufs-sysfs.c | 64 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 61 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
> index 623c56074572..54e9f3bca9db 100644
> --- a/drivers/scsi/ufs/ufs-sysfs.c
> +++ b/drivers/scsi/ufs/ufs-sysfs.c
> @@ -252,6 +252,31 @@ static ssize_t ufs_sysfs_read_desc_param(struct ufs_hba *hba,
>  	return ret;
>  }
>  
> +static ssize_t ufs_sysfs_write_desc_param(struct ufs_hba *hba,
> +				  enum desc_idn desc_id,
> +				  u8 desc_index,
> +				  u8 param_offset,
> +				  const char *buf,
> +				  ssize_t buf_size,
> +				  u8 width)
> +{
> +	int ret;
> +	unsigned long long value;
> +
> +	if (kstrtoull(buf, 0, &value))
> +		return -EINVAL;
> +
> +	/* Convert to big endian, and send only the appropriate width. */
> +	value = cpu_to_be64(value);
> +	ret = ufshcd_rw_desc_param(hba, UPIU_QUERY_OPCODE_WRITE_DESC, desc_id,
> +				desc_index, param_offset,
> +				(u8 *)&value + 8 - width, width);

Instead of using the above construct, please provide separate versions of
ufs_sysfs_write_desc_param() and ufshcd_rw_desc_param() for each supported
value of "width" (8, 16, 32 and/or 64) and also use the __be8 / __be16 /
__be32 / __be64 annotations for big endian numbers such that it becomes
possible to verify endianness correctness with sparse.

Thanks,

Bart.
