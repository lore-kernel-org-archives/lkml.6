Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751885AbeCVQdp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 12:33:45 -0400
Received: from mail-dm3nam03on0088.outbound.protection.outlook.com ([104.47.41.88]:30912
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751455AbeCVQdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 12:33:43 -0400
From: "Madhani, Himanshu" <Himanshu.Madhani@cavium.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Trapp, Darren" <Darren.Trapp@cavium.com>,
        "Tran, Quinn" <Quinn.Tran@cavium.com>
Subject: Re: linux-next: build failure after merge of the scsi-mkp tree
Thread-Topic: linux-next: build failure after merge of the scsi-mkp tree
Thread-Index: AQHTwaahucMJWTyRI0S1+v/TqjoPR6Pcc8QA
Date: Thu, 22 Mar 2018 16:33:40 +0000
Message-ID: <A250A57E-79F6-4DB8-B956-BFFC60FBDA5A@cavium.com>
References: <20180322172503.2d8e72ef@canb.auug.org.au>
In-Reply-To: <20180322172503.2d8e72ef@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Himanshu.Madhani@cavium.com;
x-originating-ip: [173.186.134.106]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN4PR0701MB3821;7:4S7fJEEWUTZfdskIJLaqNaLwZOlTD+Y/clwYBXXemBrCecJqXVLPW9GL+wfotfaYW21RSXxkcsrITX7FeJFVbgW6p+LfPLBRI6gv+iIiaqC1oEvT4NeQh32zF+dAmDJQ/osZgwRO/+gBuX1L+Avj57q36aJ6MRsh7ZincaHyspoExuXglvOnNK9Grt+9HKZoLN9V8/Y8JgUWaa2s2vTp2k3SP1VzJLieF0xA+myDzU/OtpVDN9YooqHReenv0TFa
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39380400002)(366004)(396003)(346002)(376002)(39860400002)(189003)(199004)(6506007)(59450400001)(2900100001)(106356001)(25786009)(86362001)(14454004)(186003)(53546011)(72206003)(54906003)(316002)(97736004)(66066001)(102836004)(33656002)(6116002)(3846002)(76176011)(68736007)(6512007)(6246003)(478600001)(82746002)(107886003)(6436002)(6916009)(99286004)(26005)(229853002)(7736002)(3660700001)(4326008)(8676002)(3280700002)(36756003)(8936002)(81166006)(83716003)(53936002)(81156014)(2906002)(305945005)(5250100002)(6486002)(105586002)(5660300001)(446003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3821;H:SN4PR0701MB3632.namprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-correlation-id: 672ad713-43b1-4d3a-9f69-08d59012ab71
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN4PR0701MB3821;
x-ms-traffictypediagnostic: SN4PR0701MB3821:
x-microsoft-antispam-prvs: <SN4PR0701MB382155263CE0D6433E3EDF7DF5A90@SN4PR0701MB3821.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:SN4PR0701MB3821;BCL:0;PCL:0;RULEID:;SRVR:SN4PR0701MB3821;
x-forefront-prvs: 0619D53754
x-microsoft-antispam-message-info: SNWghpJIv7OTbdfR20XPTtfHlxAmW0LuBJEpGWX1T9VX3giRYbyDVrDXlAHMBHp8WjadsEdrVFQi8kAqZo+0nvvkQ1PXXpRpeKIgrMIyb72BK59CqefsyadCCeUjTB4Pwf0GvOATwzWPOw9DeNLwmndkGr0tV06kSBKwx3ujSsoJ9IjeONz9I7CIXXH5dmOqhGiF5g0qOP53RdfS0xOmHskVkrHeOiG/IoFzJ8ECiK88p6sCdRRsTwOvHzdufNjqF/4Kbo6tWUMOWf9yRr8ovwiiQTqPQNOF4IBxg6MZgQeuuhtL/O3NwEoAmUmqTmlNEgXrQjDBAtCel0FPyOJdrA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A2906797B768C240944FF26AB5C3F827@namprd07.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 672ad713-43b1-4d3a-9f69-08d59012ab71
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2018 16:33:40.2173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3821
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2MGXo3K005739

Hi Stephen, 


> On Mar 21, 2018, at 11:25 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> Hi Martin,
> 
> After merging the scsi-mkp tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> drivers/scsi/qla2xxx/qla_gs.c: In function 'qla24xx_async_gnnft_done':
> drivers/scsi/qla2xxx/qla_gs.c:3974:7: error: 'fc4type' undeclared (first use in this function); did you mean 'fc4type_t'?
>  if ((fc4type == FC4_TYPE_FCP_SCSI) && vha->flags.nvme_enabled)
>       ^~~~~~~
>       fc4type_t
> drivers/scsi/qla2xxx/qla_gs.c:3974:7: note: each undeclared identifier is reported only once for each function it appears in
> drivers/scsi/qla2xxx/qla_gs.c:3975:3: error: too few arguments to function 'qla24xx_async_gpnft'
>   qla24xx_async_gpnft(vha, FC4_TYPE_NVME);
>   ^~~~~~~~~~~~~~~~~~~
> In file included from drivers/scsi/qla2xxx/qla_def.h:4633:0,
>                 from drivers/scsi/qla2xxx/qla_gs.c:7:
> drivers/scsi/qla2xxx/qla_gbl.h:661:5: note: declared here
> int qla24xx_async_gpnft(scsi_qla_host_t *, u8, srb_t *);
>     ^~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>  33b28357dd00 ("scsi: qla2xxx: Fix Async GPN_FT for FCP and FC-NVMe scan")
> 
> interacting with commit
> 
>  2b5b96473efc ("scsi: qla2xxx: Fix FC-NVMe LUN discovery")
> 
> from Linus' tree.
> 
> I have added the following merge fix patch for today. Unfortunately it
> produces this warning, so a better merge resolution is needed ...
> 
> drivers/scsi/qla2xxx/qla_gs.c: In function 'qla24xx_async_gnnft_done':
> drivers/scsi/qla2xxx/qla_gs.c:3974:9: warning: 'rp' may be used uninitialized in this function [-Wmaybe-uninitialized]
>  if ((rp->fc4type == FC4_TYPE_FCP_SCSI) && vha->flags.nvme_enabled)
>       ~~^~~~~~~~~
> 
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 22 Mar 2018 17:09:38 +1100
> Subject: [PATCH] scsi: qla2xxx: merge fix in qla_gs.c
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
> drivers/scsi/qla2xxx/qla_gs.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
> index f84807e850c3..d33f4619332e 100644
> --- a/drivers/scsi/qla2xxx/qla_gs.c
> +++ b/drivers/scsi/qla2xxx/qla_gs.c
> @@ -3971,8 +3971,8 @@ void qla24xx_async_gnnft_done(scsi_qla_host_t *vha, srb_t *sp)
> 	vha->scan.scan_flags &= ~SF_SCANNING;
> 	spin_unlock_irqrestore(&vha->work_lock, flags);
> 
> -	if ((fc4type == FC4_TYPE_FCP_SCSI) && vha->flags.nvme_enabled)
> -		qla24xx_async_gpnft(vha, FC4_TYPE_NVME);
> +	if ((rp->fc4type == FC4_TYPE_FCP_SCSI) && vha->flags.nvme_enabled)
> +		qla24xx_async_gpnft(vha, FC4_TYPE_NVME, NULL);
> }
> 
> static void qla2x00_find_free_fcp_nvme_slot(struct scsi_qla_host *vha,
> -- 
> 2.16.1
> 
> -- 
> Cheers,
> Stephen Rothwell

Thanks so much to attempt to fix the build failure. I was aware of this issue and had 
send the diff yesterday with change that should be used for resolving merge conflict and
compile failure. 

Please use following to fix for the merge conflict and compile failure. 

diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 403fa096f8c8..21eff2d30266 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3973,9 +3973,6 @@ void qla24xx_async_gnnft_done(scsi_qla_host_t *vha, srb_t *sp)
       spin_lock_irqsave(&vha->work_lock, flags);
       vha->scan.scan_flags &= ~SF_SCANNING;
       spin_unlock_irqrestore(&vha->work_lock, flags);
-
-       if ((fc4type == FC4_TYPE_FCP_SCSI) && vha->flags.nvme_enabled)
-               qla24xx_async_gpnft(vha, FC4_TYPE_NVME);
}

static void qla2x00_async_gpnft_gnnft_sp_done(void *s, int res)
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 5c5dcca4d1da..dab847ba4bce 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4822,9 +4822,10 @@ void qla24xx_create_new_sess(struct scsi_qla_host *vha, struct qla_work_evt *e)
                       fcport->d_id = e->u.new_sess.id;
                       fcport->flags |= FCF_FABRIC_DEVICE;
                       fcport->fw_login_state = DSC_LS_PLOGI_PEND;
-                       if (e->u.new_sess.fc4_type == FC4_TYPE_FCP_SCSI) {
+                       if (e->u.new_sess.fc4_type & FC4_TYPE_FCP_SCSI)
                               fcport->fc4_type = FC4_TYPE_FCP_SCSI;
-                       } else if (e->u.new_sess.fc4_type == FC4_TYPE_NVME) {
+
+                       if (e->u.new_sess.fc4_type & FC4_TYPE_NVME) {
                               fcport->fc4_type = FC4_TYPE_OTHER;
                               fcport->fc4f_nvme = FC4_TYPE_NVME;
                       }
(END)

Thanks,
- Himanshu
