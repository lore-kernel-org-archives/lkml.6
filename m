Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751513AbeDDGYV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 02:24:21 -0400
Received: from mail-eopbgr10056.outbound.protection.outlook.com ([40.107.1.56]:21728
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751274AbeDDGYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 02:24:15 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com;
Date: Wed, 4 Apr 2018 09:24:04 +0300
From: Leon Romanovsky <leonro@mellanox.com>
To: syzbot <syzbot+4b6afe4bdd99cb99e664@syzkaller.appspotmail.com>
Cc: dasaratharaman.chandramouli@intel.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        markb@mellanox.com, monis@mellanox.com, parav@mellanox.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: stack-out-of-bounds Read in rdma_bind_addr (2)
Message-ID: <20180404062404.GR25411@mtr-leonro.local>
References: <94eb2c0b8e086ce11505689442f9@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YzdYn+D7cUqe+VA3"
Content-Disposition: inline
In-Reply-To: <94eb2c0b8e086ce11505689442f9@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [213.57.247.242]
X-ClientProxiedBy: DB6P190CA0005.EURP190.PROD.OUTLOOK.COM (2603:10a6:6:2f::18)
 To HE1PR0502MB3913.eurprd05.prod.outlook.com (2603:10a6:7:87::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b991514b-c71e-4d25-bd8d-08d599f4ada9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0502MB3913;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0502MB3913;3:XYei1rQQYMokkfqXT5yxoPyHxkwt9bt0XtImmsc3qv0NuO94AFMRu9stwENOhoFKeF3unc6ahiwnvnt/lpOlQMN4X1RElo1RCgsgvvRD6ZRH3QwPYXuxpuZp107D/dKcsNvmC2cwnaZQHp7AGJo45GVXhDDODPjlXM3jbsTqhSjFEwGaWZZZk2px9h2RWQQtdUFoaapsO9gL3SZc9CtpDOhCZ91eu7rF5eXjmPOoHMWnBP86DZ2CX/1kp7wdlAYN;25:rRNrgQBblC2ySrKSFLSHr5mZFGodcDj02s43bl5YTEbtIbfag91onBxNo4zTGj01GeRMNEMNhWJP2XhsHlvxGLzlIY/rCTTn0sZ0/jSvWWeelOqApDVRcaGfBhvq6iCD69kva98ZKGUWuFgdhxNh1VgCyeecv6TY63ah06yPkrgh0aVfw3LDCBCP/CtwMOLkPTB8rpBeevymylYMRsJqYPtkYs/UJqAw6osfqUGBcSY3dyhPvxgLqhDnY9FDf9z1c00YU2SmkBQnapLVpNlsLZIPedm4x4UL0DycxdYUvZR9COSszPOU9lWgv7XD0h4tJeo+WWLsNgtQxv8Et+kp1g==;31:/KcXBsIlLgyxnLzyqZ6+OP53W8NEy3xzNahmAfXYcVMoYi5lcwqc9oPKim1B9WAlqoiVX4iCboRrzsF6XdXgnxIglXQgd2FtXY7Y88GXiEdRInakjuOZ0AxNEu5gMcYIOsBnopUdCNmYPJmWQE93ZU12oQx9JB0kW6MGLsJJX7R3tKTPp+s+8CppJQ9PVBXFUb6u+6uvHS0LWjVSmCcJgp9uk7jWd0c+zrUD5M8iEw4=
X-MS-TrafficTypeDiagnostic: HE1PR0502MB3913:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0502MB3913;20:+r9YhKvAelEEN/tBMAlOpe8m+2j3AetkLBj8F+PhJFabV9AohVBHVtabIpQrdfEEe7y0SiH7RHLZTQq2MxuzakI4vNJfFkILWw63CC3kGWey9pIxlEujBL6H075yUVYE2x94S1DX8uRkpr94YWzBtQnArpJggFwVtXL69HiJH+laBNarIgMt254sjBb3kEFFgrRkUndw+ysTPFSW/h+mZicHSNRt93uZeV5BL1qIFn4dZUT4VTKY7FWMaYDPxLJdvM3b03deOnPJvFgduu3at9lMcL8jL7/7xJequ8LvZ1jA19A1m5r8eJQ2UTnUEw0acadBqKRafRmjxfSDbtUaVSVl//WinqsYywdegitJiHq56xcEsORxjSMI/H4wA7lxPuscQyY3e3xUougzBPxbYs9VqJ/h3Fhcbg4Xow27KD/ylU5XnnvwwquPAlkd+nGPYfDaW3ZTHeUnpgUmDlDnuqhmaGkE7jRWlIU/qru2GighXUGuaf3hOZHydV740kzc;4:g1gMXx/eD7V82Bw4cYPJqbCxL57mrqSPC291+2r5XwfQ7H2/qnIlOc55KNcvLlTQNa4NzQvY4n+J8y4zsAoRhN/6cT3M/ZjV1DxYUJAE5ZIacVhtxvTle3JcPMe7etmO3NrnurySTFKvPfskO69rpsK3q5QtcQfAxa4P3mvcjlY3bDPOI+AqN96ZZdLvdwqe8NoOTjpFrXQ9g+PExIlLjnyaVuX71csGyNazlCgusABaX2vbyOHA/BAeUriZpeIPmS/uoOsFRzylo8AL3jh+P8+RDu0rnE0oPsGXJg/RYmd/jh32x+ZyCK5H7XH6EkNV
X-Microsoft-Antispam-PRVS: <HE1PR0502MB39131FA8182595C03EBD4B33B0A40@HE1PR0502MB3913.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(148501403981450);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0502MB3913;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0502MB3913;
X-Forefront-PRVS: 0632519F33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(39380400002)(346002)(39860400002)(396003)(366004)(199004)(189003)(81166006)(956004)(476003)(84326002)(446003)(6486002)(44144004)(4326008)(81156014)(478600001)(8676002)(8936002)(966005)(97736004)(6496006)(59450400001)(52116002)(33896004)(26005)(76176011)(68736007)(16586007)(11346002)(5890100001)(53936002)(316002)(105586002)(9686003)(2906002)(6306002)(1076002)(3846002)(6116002)(21480400003)(98436002)(7736002)(6666003)(11609785009)(25786009)(58126008)(76506005)(229853002)(186003)(66066001)(6246003)(386003)(16526019)(5660300001)(33656002)(86362001)(106356001)(305945005)(63394003)(486006)(18370500001)(99710200001)(2700100001)(505234006);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0502MB3913;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0502MB3913;23:Cr8c8dK4QTOmw0+ppIxfXCDMl/Uk3GlzoJK/a9j?=
 =?us-ascii?Q?RlagpKjSNT4txrP5dHvKWpkdSonECY/wv6nhYqUFGcPV+s5tHW9Q78x+joo/?=
 =?us-ascii?Q?E76bqBltXkGb0IWPy0iarEWd0vckpGB9YrgRPhrf0G5i2oG+wp4v1llYQL3x?=
 =?us-ascii?Q?SrO69oNUwPJKAfK/yrT9Ay+Cuw+mbVPoy7YkPsT1qEYOfqj3wUVU0pLXZ547?=
 =?us-ascii?Q?HYN64h7xwE1+izCdKqUQXGPp/v9wTpGXfrOnk7+konkb4OmvA8ju9F9liMXa?=
 =?us-ascii?Q?7KprEegZcX1P/AaKobr658AIZMgZliLEzJNTAGzwRQThaAWr8jcK9XL9Ta/R?=
 =?us-ascii?Q?dt7Ln/VCPiX2acy4MVnAtuHTh3imvbvV/VibRiEIcBapUh/LoMPzge0He/9S?=
 =?us-ascii?Q?SmSLHH9MGZkp0koRwRBmU0DtHUZg5ry//54aAUZwaobJcFoh0VhRhYcDnobM?=
 =?us-ascii?Q?5DbQkMaYy2hawJa6jDNZq3mpy+0JI2F6fpynY85KBFSRfPJCBQVG3VIHdim7?=
 =?us-ascii?Q?MiIxEasRYRjoc6ByTuLf7V0Ej2Y4a9wwcD1LCEa58sWzLBwivOBnWeh1z6v3?=
 =?us-ascii?Q?HuD1VgzFWAKdDn7VvPS+EpTCN8fddVw7/5jeotYrZcng3J67aKh8dUIQPc7m?=
 =?us-ascii?Q?SSnlfm1fBGhwJ0669Qix+csDKjAZyBiwckKtRBlEk23IjgOFbpbsW/7JNs2O?=
 =?us-ascii?Q?LxIRFc8yTUqnW4VJR963K4tcIRsenCunBZoqFjgvFeNYzBFe8JKJPIqcys+u?=
 =?us-ascii?Q?4T5bb7M3VbiQ83wyQMo3rM2HFm3y8+eDFGdR73JHTPb8TShi6zlwWs0OnOux?=
 =?us-ascii?Q?s6nFZjQatFqVhPS5cRrcVPFnrbs9JmaTbgyEtKgUCyTz3UttOgUud1aaJYB9?=
 =?us-ascii?Q?TsyOajAlREapuutBMNqVLswpbey0WdocCl+qYh7mjKA/Qqhp5iEuskAICvv+?=
 =?us-ascii?Q?4mpvwAdqM2duIgkjurhKmluUMYP1l+v23sIQ8NNxY9DSWdXpJmV9KocioQ4K?=
 =?us-ascii?Q?hyE2rUvhsp4Kf2/IUtSY1pSo/MnDeG0h6PW16J5EnmrJd3MQWIlCoCtuuhMS?=
 =?us-ascii?Q?u2tNBQTpQh5lLE5ob0DNn11R6bsMLrG7XYvxW+c40ebwLLFj4q4DXq0rMyvm?=
 =?us-ascii?Q?dkrz6/elPwh9JjCl5xK211phsyaDEn4olTvrorKj0Fd3whrnbpcGlGHUSOhI?=
 =?us-ascii?Q?qHZA4DFG3JNPcb4hJH2jWzZ6EnXDS0aWenl1JP5THzwTYyE1wdo0TqistafL?=
 =?us-ascii?Q?88GcKo4TxtacMZbF6eW834oHxdY0gCryypLXQhRzMs1hCt1se87GCbetsoEa?=
 =?us-ascii?Q?Ijhdg+HBfQ6YkxSSHFpaJgevEKB2JX8L/X+TWqEXpuiajgr7iKwAXtfOh6+X?=
 =?us-ascii?Q?FV12TrZlOuqLd+Ls8d5VZJjtJCJvk5FpEMAKDW5sUdjDY8YI/1NifsxBkLHT?=
 =?us-ascii?Q?88d5hE3VY6j0T4YUNI6uAvL2wnshNG5H2eZbXKDQ2wIVqKHZrBmqhn6rdCo8?=
 =?us-ascii?Q?7/IrtICNsf8/oB+SzIT7yNIL0xocJB+Sysjw=3D?=
X-Microsoft-Antispam-Message-Info: J2F1kO3Kuk+PqPpV3fVMpSXd3sF2aJ9GTJ3l+qVN3A/ydomiAj/SlJeOUeOjAIjZGeXMSVAluPnIRgVUjlLv+bylawG7yJPusGpFn2CiziJP+JUje1sChy8jsmZ7V4HfbJOAY/exvDQsCnS0o0mnawv2IEVvdu7tC1rFARBg+N7saxUhpVPoRJLrd86FCIfF
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0502MB3913;6:gFRa4OvRYEg+bkQ8hlthOGIxLis5MObJ+LUXsiBmxGIW5ui8cX3ySHu+1ennxq/fhIhofHpHG5OK6/pXLULN3aZjyTv0tbfj/Q6ZTnkfDwNQ7qJV1HFZy8kWBgvHfTjwi40DAJDRfoknmub4qn/TrbjUfRPMSSNn1e4wHzTJOSkjlDPXVrwy/wh0DO/3aDsMdy2lpdBZZ5MR2dIZKh1XvLRk6wYr5BB1Qn8HWpNHIkFizmphe64u1SngNncfgrUIme4KFAUEQX2xuS5ol75nWCK5sEPnP46hY80qa+pvqiEowildz+nGqFIdL6GwypNC/jKbvVUy0UC7uYjmZyn7FILEswZJY7Is6z+0sj35JWI7zZKiGuY6J28GBkcwcJRC59gvHCq5KWaFtd2GarYMcNfK2QZhNVCPF6dX/bBbXfBMpEfKN4YB5Dbb9tsDKuS9ZEcgo2SvUg5RFlpPMv7qmw==;5:ny1YsnbED2afID33l+ir3gK8DQCFMpLA+7Lf1PqOOQxM69WvdUEf+IFkIhygz+tRRHLiXcoyoAH/WNjwm6CoUHSad344KL7hcMkmHWYrpvcUOJZ5Jb+17FNsGGKbXVZBIVxmQxNNaOwWEr4pGdzacbIv/Otjik2E6AApBJvAMTk=;24:/Qi2keMoI5O/m7arodC9N05BfMXlQHgxw/aEHhFRm38ZFaQiH5YDBShAlHwPy0rQg4e8/cXXZn0Q0tj3I2E5nxzanfXY0D393pojEs7QUgA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0502MB3913;7:KX2WfRUJ5v/CHY/qmo8jjZMwRtDZU06gBtWSQSOKpDKQwgGqveWb5KANaxtOdR5e6TTkuSfQaReiVmOywZcJFE3e0v4zyX1a5IliOKpkqJzEuM8yByUe10FMq5WMJTyespOYoll0fPRUlfNWn4Wba1k3MMJv7LoUy2SeHWcCKef3G5ZICE76gMWRrtQ3fkQfNP6UKIyaNnsHZMU8IPrf8W3sZtUNjpF4wo61oN3yeTpy4v5IZF6PMTo/L/VBk208
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2018 06:24:10.4633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b991514b-c71e-4d25-bd8d-08d599f4ada9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB3913
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YzdYn+D7cUqe+VA3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

#syz dup: kernel BUG at lib/string.c:LINE! (3)

On Thu, Mar 29, 2018 at 03:01:02PM -0700, syzbot wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> 0b412605ef5f5c64b31f19e2910b1d5eba9929c3 (Thu Mar 29 01:07:23 2018 +0000)
> Merge tag 'drm-fixes-for-v4.16-rc8' of
> git://people.freedesktop.org/~airlied/linux
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=4b6afe4bdd99cb99e664
>
> So far this crash happened 4 times on upstream.
> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6021023174492160
> syzkaller reproducer:
> https://syzkaller.appspot.com/x/repro.syz?id=6269942299099136
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=6347752745205760
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=-8440362230543204781
> compiler: gcc (GCC) 7.1.1 20170620
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+4b6afe4bdd99cb99e664@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
>
> ==================================================================
> BUG: KASAN: stack-out-of-bounds in memcpy include/linux/string.h:345
> [inline]
> BUG: KASAN: stack-out-of-bounds in rdma_bind_addr+0x13b/0x1d60
> drivers/infiniband/core/cma.c:3361
> Read of size 48 at addr ffff8801af717a50 by task syzkaller366236/4421
>
> CPU: 0 PID: 4421 Comm: syzkaller366236 Not tainted 4.16.0-rc7+ #5
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x24d lib/dump_stack.c:53
>  print_address_description+0x73/0x250 mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report+0x23c/0x360 mm/kasan/report.c:412
>  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
>  check_memory_region+0x137/0x190 mm/kasan/kasan.c:267
>  memcpy+0x23/0x50 mm/kasan/kasan.c:302
>  memcpy include/linux/string.h:345 [inline]
>  rdma_bind_addr+0x13b/0x1d60 drivers/infiniband/core/cma.c:3361
>  ucma_bind_ip+0x10a/0x190 drivers/infiniband/core/ucma.c:639
>  ucma_write+0x2d6/0x3d0 drivers/infiniband/core/ucma.c:1649
>  __vfs_write+0xef/0x970 fs/read_write.c:480
>  vfs_write+0x189/0x510 fs/read_write.c:544
>  SYSC_write fs/read_write.c:589 [inline]
>  SyS_write+0xef/0x220 fs/read_write.c:581
>  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x43fdd9
> RSP: 002b:00007ffc69ab4bb8 EFLAGS: 00000217 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fdd9
> RDX: 0000000000000090 RSI: 0000000020000080 RDI: 0000000000000003
> RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
> R10: 00000000004002c8 R11: 0000000000000217 R12: 0000000000401700
> R13: 0000000000401790 R14: 0000000000000000 R15: 0000000000000000
>
> The buggy address belongs to the page:
> page:ffffea0006bdc5c0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
> flags: 0x2fffc0000000000()
> raw: 02fffc0000000000 0000000000000000 0000000000000000 00000000ffffffff
> raw: 0000000000000000 ffffea0006bd0101 0000000000000000 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8801af717900: 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 04 f2
>  ffff8801af717980: f2 f2 f2 f2 f2 f2 04 f2 f2 f2 f3 f3 f3 f3 00 00
> > ffff8801af717a00: 00 00 00 00 00 f1 f1 f1 f1 00 00 00 00 00 f2 f2
>                                                              ^
>  ffff8801af717a80: f2 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f1
>  ffff8801af717b00: f1 f1 f1 00 f2 f2 f2 f3 f3 f3 f3 00 00 00 00 00
> ==================================================================
>
>
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> If you want to test a patch for this bug, please reply with:
> #syz test: git://repo/address.git branch
> and provide the patch inline or as an attachment.
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line in the email body.

--YzdYn+D7cUqe+VA3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkhr/r4Op1/04yqaB5GN7iDZyWKcFAlrEb4QACgkQ5GN7iDZy
WKcoHRAAquAbRWFf+Baxyt6awf/DQOtzhkXgDSoMTOqcmh/JeMtiR3roj5Ur+mkj
Eo+qq3/jhoV9pGCNGTzdGJu41n+hgozyPxvKc8pB9G1F9QU8uZhZmRCyMIRD079j
+8Vazx+QCMU84x0Sbsg2EuBQFo0BC4QtlWhWowvT1nZo1nIYx7p4zLmsRWqb+lqr
Wjd+7Vrigsc6BtKCjpm221MOyQRxboM5Vhx2SweZv8qbKEzqjSYtDEWa6tbtnpca
GDPWoay4398aDfdFfC7jJyzyaHm8RIeLsuYqZXH8le5BIHFdfSxVEdSZ22zGhfqx
ULAi0PzYnqnA+/n1zRbVyWUJ2UffoGy90jPASPA3PdppCFq/B1ve+V9E26HOLyUY
YtiUu2mCukfAbUhsLkwdU5/zsyu8jdV6OMFdsa7q7ZUyZBbLGwcC85DtfJiBLedQ
Nf1eLxicCNZ3hT9MZeopWF+6GfOt02rFkBqud/60x57JifQQ6Su4w9YFvYalsfXk
qsaLGBFXkGEF7P0runMs1Zuq5/vquwSdgri1oiRQhCZ78BFThIBATXq0Rr0Yoj+M
NB1p2VckWCwPSSmFek8+wsjXRKp1HFp4PGtLYN7/Q6y3lTVKI4bCNuLStOpm7ALJ
lECoPx1W4j+yvPUQ+UrA05vestOhcY7129kntwoRrsmILndxJeE=
=EZ+1
-----END PGP SIGNATURE-----

--YzdYn+D7cUqe+VA3--
