Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeCPMja (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 08:39:30 -0400
Received: from mail-by2nam01on0069.outbound.protection.outlook.com ([104.47.34.69]:6020
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750929AbeCPMj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 08:39:29 -0400
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "yuyufen@huawei.com" <yuyufen@huawei.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
CC: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH] jffs2: remove fd from the f->dents list immediately.
Thread-Topic: [PATCH] jffs2: remove fd from the f->dents list immediately.
Thread-Index: AQHTvRWf/Uy0bZGoI06DBqjXqWoVpaPSzXSA
Date: Fri, 16 Mar 2018 12:39:25 +0000
Message-ID: <1521203963.4790.208.camel@infinera.com>
References: <20180316110522.1120-1-yuyufen@huawei.com>
In-Reply-To: <20180316110522.1120-1-yuyufen@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BLUPR10MB0706;6:rqk2f9aMWzZh2+PyPiMtEnIDlNfDc8MWSl/opZWp63qrkyrFvcKlUqj3u5L6eBLlx97pLH22Pr8x8avTUCABc3groGvd9BZTRlbE1rtQ501Jp1BjFej4JFvyVyLvydbwBWCvwihC53UJ+QES6nLRK2wFCNSsXZAgpr3FLzxtefMt8Tk/YR9FOraTuSP6kXo7ZbUGEYwx+Tq2vbZZOSYLCJ0VMPfrenOwzf+6ymctGRGXNQc3ANUKi9cuRhWFDt0bbs9UEopcuIiLu32t1TUrHGOvTP3c1WP6RFQxHJ+bLqhQ5b3ZE4pa7AUE6/PQSxeZ9x5a04Tm8uyWdosaQkNjSpX7oi6RltTPbKnRbsDl3Hf84L/TVqxsrsBMkeH9muN4;5:J0jBt5Z7G4aB3usMGli7kLUUk/cVxZGr9gT6zeAFubxTOkFQmPKHXDD0g59fsOGt/LLWPFY8fi3RRsM4Ng13w0GmdE6Pv5mhWuSqYY+CB03WwBcIUkDn30WvnhrFdbnrbEhDqL9ETZ+42xHtSLA+N4lCeuGx5V57+jGv3AQp5BU=;24:zwrfnlz70Yyz88AIl4AHiS5GB5s8cOC3o1H6QLVmkIyWGyMNZzRxj05JbQx/XrxiQ6PMlKo3f/i5CMAtvEKmJ/5NkYqZcpwF5DwmbJrg4ck=;7:NzoKfNi/38CtjQ/86Yz75odXEdFHSep4+cxNGt4NmE1EyUU1gDTJ4HgEvnS+8qztMDpI7PRX2bnazVsvprg1xVEywOr6B/59zTLM3ccm+yfzhQaqHAyzfkioVVbNHmp3DKBCOkrPlItEH4WsC5PC5EbFXcA0xkFlT1Abn4VGC1wKS+Foaxq1W0G7LybB0igJ1QtDh20f/SRvzwB3zi/6FVSpUmN5LAF+7HiZz8Is3yzDxFPPe1ecDzGcoUkw/OJ6
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e39a222a-cc12-4ba4-e54e-08d58b3af3c7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BLUPR10MB0706;
x-ms-traffictypediagnostic: BLUPR10MB0706:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com;
x-microsoft-antispam-prvs: <BLUPR10MB070692DD63F6421BBCB77E8FF4D70@BLUPR10MB0706.namprd10.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501281)(52105095)(3002001)(10201501046)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BLUPR10MB0706;BCL:0;PCL:0;RULEID:;SRVR:BLUPR10MB0706;
x-forefront-prvs: 0613912E23
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(39380400002)(346002)(366004)(199004)(189003)(377424004)(305945005)(7736002)(5890100001)(2501003)(72206003)(5250100002)(102836004)(99286004)(6246003)(3660700001)(3280700002)(68736007)(5660300001)(86362001)(54906003)(110136005)(2906002)(36756003)(316002)(3846002)(6116002)(25786009)(66066001)(6486002)(76176011)(4326008)(966005)(97736004)(81156014)(81166006)(8676002)(8936002)(105586002)(478600001)(14454004)(103116003)(6512007)(6306002)(2900100001)(106356001)(186003)(6506007)(59450400001)(53936002)(229853002)(2950100002)(6436002)(26005)(14773001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR10MB0706;H:BLUPR10MB0098.namprd10.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: J225vMfDSJz0CBcrJxQKYDLpjMCtO2bh8cWrQyvDtWJnWyOva0oL8S3TYzQ7NWy+oBAmiItUuN1/4U9OvJDs+7l2BJu2n/Bir5d5EzVh5BQ/aJHxo2EX6ybCrEVbXXyVC++ADC8vnititZQ+HA4ly+bK0xnoGnjCi43lsE0bqKZ5xAD/BTnGvDEhllFSjGnmBkvpxqeWKn6u1aRxh7nLmA40hbdQM/ldLSrDKn4TR2qwsMa6Z59Es/yRijc1iZpTDjYTpvp80ORTjkI9vDAsNZVmLuDoWiKahv3hOTXIAg6MvrMT7Gx9zgp4VU4/35WqcE2Uv5cMeGVm2j7T+moelQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEC82F067C62F24A926A82DC0846B5D8@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e39a222a-cc12-4ba4-e54e-08d58b3af3c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2018 12:39:25.5871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR10MB0706
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2GCdbf0030534

On Fri, 2018-03-16 at 19:05 +0800, Yufen Yu wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> commit 15953580e79b ("[JFFS2] Improve getdents vs. f_pos handling on NOR flash.")
> is introduced to resolve 'rm -r', which cannot remove all files:
>     http://lists.infradead.org/pipermail/linux-mtd/2007-October/019658.html
> 
> However, it can cause the following issues:
> 
> 1. 'deletion' dirents is alway in the f->dents list, wasting memory
>     resource. For example:
>         There is a file named 'file1'. Then we rename it:
>         mv file1 file2;
>         mv file2 file3;
>         ...
>         mv file99999 file1000000
> 
>         When CONFIG_JFFS2_SUMMARY is not set, file1~file1000000
>         always in the f->dents list.
> 
> 2. Since the list become longer and longer, more CPU time is used
>     to traverse it.
> 
> After reverting the commit, we test 'rm -r', which can remove all
> files, and all seems OK!

UHH, this is mine (and Davids work from 2007)!
I cannot remember  any details this long afterwards but I guess you cannot just
revert that part as it triggers some other bug, David?

 Jocke

> 
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>  fs/jffs2/write.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/jffs2/write.c b/fs/jffs2/write.c
> index cda9a361368e..1deed35beb50 100644
> --- a/fs/jffs2/write.c
> +++ b/fs/jffs2/write.c
> @@ -598,31 +598,32 @@ int jffs2_do_unlink(struct jffs2_sb_info *c, struct jffs2_inode_info *dir_f,
>                 jffs2_add_fd_to_list(c, fd, &dir_f->dents);
>                 mutex_unlock(&dir_f->sem);
>         } else {
> +               struct jffs2_full_dirent **prev = &dir_f->dents;
>                 uint32_t nhash = full_name_hash(NULL, name, namelen);
> 
> -               fd = dir_f->dents;
>                 /* We don't actually want to reserve any space, but we do
>                    want to be holding the alloc_sem when we write to flash */
>                 mutex_lock(&c->alloc_sem);
>                 mutex_lock(&dir_f->sem);
> 
> -               for (fd = dir_f->dents; fd; fd = fd->next) {
> -                       if (fd->nhash == nhash &&
> -                           !memcmp(fd->name, name, namelen) &&
> -                           !fd->name[namelen]) {
> -
> -                               jffs2_dbg(1, "Marking old dirent node (ino #%u) @%08x obsolete\n",
> -                                         fd->ino, ref_offset(fd->raw));
> -                               jffs2_mark_node_obsolete(c, fd->raw);
> -                               /* We don't want to remove it from the list immediately,
> -                                  because that screws up getdents()/seek() semantics even
> -                                  more than they're screwed already. Turn it into a
> -                                  node-less deletion dirent instead -- a placeholder */
> -                               fd->raw = NULL;
> -                               fd->ino = 0;
> -                               break;
> +               while ((*prev) && (*prev)->nhash <= nhash) {
> +                       if ((*prev)->nhash == nhash &&
> +                               !memcmp((*prev)->name, name, namelen) &&
> +                               !(*prev)->name[namelen]) {
> +
> +                                       struct jffs2_full_dirent *this = *prev;
> +
> +                                       jffs2_dbg(1, "Marking old dirent node (ino #%u) @%08x obsolete\n",
> +                                                       this->ino, ref_offset(this->raw));
> +                                       *prev = this->next;
> +                                       jffs2_mark_node_obsolete(c, this->raw);
> +                                       jffs2_free_full_dirent(this);
> +
> +                                       break;
>                         }
> +                       prev = &((*prev)->next);
>                 }
> +
>                 mutex_unlock(&dir_f->sem);
>         }
> 
> --
> 2.13.6
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
