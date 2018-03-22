Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755380AbeCVPc2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:32:28 -0400
Received: from mail-he1eur01on0066.outbound.protection.outlook.com ([104.47.0.66]:16550
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752199AbeCVPbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:31:50 -0400
Date: Thu, 22 Mar 2018 17:31:40 +0200
From: Leon Romanovsky <leonro@mellanox.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+3b4acab09b6463472d0a@syzkaller.appspotmail.com>,
        danielj@mellanox.com, dledford@redhat.com,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Johannes Berg <johannes.berg@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        monis@mellanox.com, Paolo Abeni <pabeni@redhat.com>,
        parav@mellanox.com, Roland Dreier <roland@purestorage.com>,
        syzkaller-bugs@googlegroups.com, yuval.shaia@oracle.com
Subject: Re: WARNING: ODEBUG bug in process_one_req
Message-ID: <20180322153140.GP19440@mtr-leonro.local>
References: <94eb2c0bc3aa8b2432056623c735@google.com>
 <20180322124823.GB19440@mtr-leonro.local>
 <CACT4Y+Ya8iMgV=7YGgsO2XnusF9tnGcHHPF5U5oNjQz_eJ+vMw@mail.gmail.com>
 <20180322132031.GC19440@mtr-leonro.local>
 <CACT4Y+a2KB6vvgFcqkq7cMCiCZQEFNxsCTgP+_gtgju8H2q9hQ@mail.gmail.com>
 <20180322142900.GD19440@mtr-leonro.local>
 <CACT4Y+ZEGHp9vg68O7dDfRWj+_bKZQCGQX2AcFckm8GBYaREug@mail.gmail.com>
 <20180322151358.GE19440@mtr-leonro.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DEZnBEgdqIPZuRMC"
Content-Disposition: inline
In-Reply-To: <20180322151358.GE19440@mtr-leonro.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: DB6PR0202CA0022.eurprd02.prod.outlook.com
 (2603:10a6:4:29::32) To HE1PR0502MB3916.eurprd05.prod.outlook.com
 (2603:10a6:7:88::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7c39fcc2-b281-4edf-a891-08d5900a05c5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0502MB3916;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0502MB3916;3:lmYraHGJhvuDKLHjTF0j0FhFCYmHbz9E6i5MCbSajxH1zKdGYWAlA1yvXa3gmpHgRFjaNqut9GrBX52iFlvbn/zAriJLl3HTCigRgo5Xjib2xMTgENlgbSQnAZkaSpNsndTsGnZrFgq+w4/RAAC2kT8VDBabNFMy3swsWpLJLxsdSotmA2xUL4M7wTNKd9Uue9nEyLl8LP4IjvGMpgl2wuj+2Vg5ez72hdW1CXeIAdM0gfvOFgRzSi1pVtKnnkbx;25:fYpmMf/DjHwYEF1/Pcjb5Uv1kg88WAFHs3d1J56AvzGozvUmQtxA+UmfdG4r+vVLqYlhxFV1dzbULyftNADbyLzny5nE4WwBfaxJNbxdI1pcaumCnlcG2460WWokVZCQ2ysEkDLcx4HDmZF1NJmttPeP+uSSsBjVE96osdM7RLiHe93jOO48VrYa3dzJtiZsDKcc1fSJ4tzBMfm3UCvy5O6iCsvYV3shqKx+pzcCnErLoJnl6ryXCAWV2+lYwo/PeiYmbh2tYN4O8VKO1ZRpTUKJdrwsOBgXIsHAUgENAypHkL3o7n6GB60u07VNg1FoAv2BsGqBCfzlRL8F8dEPVw==;31:yo1bPvPmD3HjI+aNGC88VcgmAq3UlpNC0xNVt450oZbyJEQct1sAkIyP56Jco8oS5ZTbkxjrQ7VruToLodha2IdVESbdjupReSrVuoRTgk3lVfSWKYY3yjznhQ6DWSnHn6Lwk5wJHVD0xyccd7FUSqaI30uI8aZF0kcJhJEbwry8+bpLy7VQIgMMTRX/zWgFKXmxOc/RgM8l40X0XKbJ84akvKItS1I+eRnPi70E/M8=
X-MS-TrafficTypeDiagnostic: HE1PR0502MB3916:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0502MB3916;20:otKjvqXVkqVmeFKATjc1R3uXTdEciGsysotJo+q2Owuf7HcrWVwUclUiYl+hwXae2kl6WclkZB7KI3Ug/ILPOIWAuRjYNzTqlUe7ZGmVusojLAm+ZD1KWigAa8UAr5OOipMNmn+A8aC/VTYllZ6buvroFLEMksLEyIgC13/TsMU229AKm2d1pct6gd3UZMQs38IrXDBfMJznPihl4Hfa3GovdAaZOFcfH/ZBQsOQKCemYk1UkOBTyGcXWn0kCMHEuNwFfZvqIHCTGaoNm79nfBeN1KX7EmFYxIB4lnTqV7p7aDOyvfb4/bt0PprYox8FqpJsy2dPAlRYzRDEMWOidoLKVwTDgJuaS27i0myEJsusDsrC2z3ooMltKZyIFzC88uNk9wfuATgvJogVbTdb9hna36yNBRKA+yd5OJBc9McsRvEs1Wdz0ABnVAAZsn5tNBEN/3vTpW0Bf9nrRoP+YL58cJtdziP+WINhxJU2w6jHmV3pmW5qH68tSDRziVOl;4:95hp/j58QSFevxaZwIojBoToWMvu0S8jsxOMCJB/5rJXi7DpIKHagCB/oV66eBpu50nW+VBac5n1ybF4fFaiYE+9UR8/0go/TbW0FmJNMav3en8TTgSbUW/uX47RL+ygIcJu7/0WuPiDZOZ+u7wZnSE+eki7+BGoxgKdhhtKJOkSsF5/RrqSI9+wmB8JszoRpHuCrPeNAfxFblTORpCaL+XVfU4UuBkNtMhpu7XYFa4pyJNbKwEN7ydMtMpECEuCsRkvb3h3lxXyRh8GfMbmhg==
X-Microsoft-Antispam-PRVS: <HE1PR0502MB3916A04F08986B75DB86936AB0A90@HE1PR0502MB3916.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR0502MB3916;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0502MB3916;
X-Forefront-PRVS: 0619D53754
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(51914003)(45074003)(6246003)(386003)(316002)(16586007)(7416002)(8676002)(54906003)(478600001)(6666003)(6486002)(2950100002)(966005)(6916009)(33656002)(21480400003)(2906002)(446003)(3846002)(76506005)(106356001)(105586002)(1076002)(58126008)(5660300001)(6116002)(11346002)(68736007)(81166006)(93886005)(8936002)(6306002)(33896004)(6496006)(76176011)(44144004)(81156014)(4326008)(63394003)(9686003)(98436002)(97736004)(52116002)(7736002)(25786009)(229853002)(305945005)(26005)(66066001)(86362001)(53936002)(53546011)(84326002)(186003)(16526019)(18370500001)(99710200001)(2700100001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0502MB3916;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0502MB3916;23:XJLQFI7o1h3MCk4os70YznqIKTPC0zzYgcnFkXt?=
 =?us-ascii?Q?dnd7gFwvxIIihWWzxeoIBrq0/w60bgGCEj6XxllpSygPhrAZambuK3+e/ZgV?=
 =?us-ascii?Q?FjIQTEj47ofzKr4nbviFsH/xyhiDtBB6ALPbqKfofL/sxRRAF8xLGKd7xg+W?=
 =?us-ascii?Q?qe4mRkSGHzdypOMHGwD6Q5B1R1ftitnx7YUGtnWss+EwyH2+OtBr977Iin/o?=
 =?us-ascii?Q?ErekDJFFQpNILvmjuYkKFD0vdftHB5z5Xw60n/NvczWX+Ifd2DOsDVD8ZDP7?=
 =?us-ascii?Q?YgUFAcjdMFoB8QkapUUFj2NMgdwMHbZCJvQ8VTNPXe/IZuExxo8OKTEfPAel?=
 =?us-ascii?Q?H9d90DNdX3N5h0lUjw98ElQXBPTutAS5Mj9dwcU8XFL2IDQwGUzDV2LcX+J8?=
 =?us-ascii?Q?Nt3nMs6/Yqahae8q0oKAAY3fyzCT6mrgphJxKbKlyO+jCAApilsw/9Q+8zhz?=
 =?us-ascii?Q?/mvveF7qY+GnxrR+TPX6Vh0ZxUOleBhSREHgzXHauISXaDBvBLhFs6IOuRYX?=
 =?us-ascii?Q?TuG6dgTmG7OXH1eajj44EbKYHPnwbYQJe7sQQZnuFoXs/ebtB08EtdZqX0fS?=
 =?us-ascii?Q?CFbbaBsbvaHA6Bi8xKkibzkYhhFmJvHTmk1LF6RWL1Jkrk93kRcqjB27wNhN?=
 =?us-ascii?Q?xdGJs4/qay4H51YmyfS1booAAnAQeIPjORkB2Z7X5BS7/l0kVoZHlfXDY6Fv?=
 =?us-ascii?Q?QMMC8H59sAG2Uajj7ep396EldtRaskDMWFUg0Z+kJzCA1pADMz78WAKOWbIq?=
 =?us-ascii?Q?pt7ks6tm6SkqzGpKmQE/Td4S2Q1sMQVxvD1Ganm2DsD7BRWknoL/+lo8qNR4?=
 =?us-ascii?Q?hoVAv/zXqFIg5gjhGXX6rgCiBZ090MDS+GWhpOGxNNeppc8TOERFPmk6P34Y?=
 =?us-ascii?Q?M3HMWMGiivzGfo7VPuUxAQPrPL0ED2EgdF2oqBVc3Loc4FBWOHTwYct1LuIT?=
 =?us-ascii?Q?IB3tlQYVEhlvPQyDmlhqAAcHHZnPKpXfMG4zt5w5sn8Wq/XJFdlrYc+11buw?=
 =?us-ascii?Q?Jmj0VJ+nVNKstS3FpWuOyU9nMVuzsLafn4it70wDEK/lAkAvzTcYK39zOnO7?=
 =?us-ascii?Q?AvVrXEeROZ9erg9fFoVwboEneEjFLVz3lLY5pE/7NsKW+lYOrL1cWBEAAjkB?=
 =?us-ascii?Q?lGeV+idIF6Sy0jRACpV86vJbzW8RsIBhC9X1gRwt8bqqs2l/2HnhvgGK+h3z?=
 =?us-ascii?Q?YoM+iU+FIOfuqU48wZ6ZGd9Ww/cEahVcmvQqnRDFyOajDrnNOYbqjHMuCyWF?=
 =?us-ascii?Q?kwoFp2dek1zOPGktFTXaNyg9Z+bVCbt3k0ICpDM1WsE/sDQBXyPoOXmRUBYO?=
 =?us-ascii?Q?P6owk1Ku3tLhF0CI3ahk5mLL+oU/ZNUhs104WR8mxV1UHw39N7pB/b1REu7G?=
 =?us-ascii?Q?QLnEofUuVKD6vx7o7zB0y1DTaXpkFp4qLiGvFRuVaGi0uZZ5N+5nVTc3yyPg?=
 =?us-ascii?Q?OpQNbb8J6WBg0nSUZEGT7YD9Uk7ZWEM5STM1gWA53s3+zQbjSF0rV677OX0m?=
 =?us-ascii?Q?EJThAqx86WBhqsIkoiOL+JfgOA3EmP08yJRa50uoMNViznt7v6LQvjcBY?=
X-Microsoft-Antispam-Message-Info: i1omQEi3qzmDC1NDLAYglQRhdFKE1LWqdZgEJLR0dWiK0ym85pAtNJqnxQQa+0//sYMOZb1NUSrTko3qYAaQO+0x3WSjag3yeZ6b3t+ae2IAFXEq4LYPe14LCvltolfugz6AmcIqJvBBfET2QNqMgqsV96825Gfsgt86NahsvV9eJiuE8ycvBcRt1fmDU0Zd
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0502MB3916;6:TyyPctguLP87UUSt1t5PYF9CMcRGvdoVrEQNGd9wrku8UJdRGVSVEuqusmru2VkTscU7yuMhL6SCGw14+tpVAF6gIW5gB0uCDjBZMJVDFdIthEBFUEzWIrY9vK+g9mbvlmsoeRFFm7lnav7Wr09K9a66JqcRFb92LQ3V1+o0Pdx5aYCeugIShLp/6gUcPTVL/aLS+Z+jxAiTPerm5gnU2cYzGjSHkL36qNhvvFfRc2Saxocl5CKbLnYWWyKiRpUmzJbu55W8UkDTlzhhyr6elY8C526ja54Vbeo75/4JdVx0aJ8B7dUe46UawvsFBNhBjjFDWvlsKaOpY0AbjFzvfiZHMRPu8VLZlZhbE+NRqCQ=;5:d4R2ObCle1xCezm9hWOJpSinZ3L7/UvfBTsnre/X3Kk2ObkqBa2To8RnGoswKdikPMYUW9I5DzPxZIMADe8VGtyiqpHJoqRp84e1zFuYD0rkYMRDdMas6GOH6SgagZ5gcOXFRt/WDUPtdKT9yIiFLwnz4d4mYESMPalr2dxJGAQ=;24:W9/SAStoxMBtyUN2GZjgpQIppRfBRt7IqWDkezWHUZgezGC9tIYpX3CmVhPRQ3ld2s9cC8etgPP0jXqFkQi+8oLs+rufTizglzlwvh4ybuk=;7:xnMFMOUK5bNilv110OzECp+PyOc3LWRR99T2n0M/rU9yjBRIKL6LG4c5SQYze91p7GZR/3PgMxv8asPXboKIT/jEom8X9Im7SYMGTEsYQni140MfN36qbyatGK1wT6kaisUEO8ei23r3hB1nsLjIFXOtsoFjXPjCoL3GsMOWIkWgONm7mfkm8ykgZC28k/c14Q/oRTRC1MB7BbDnv0zBOcRJgG7iY9vcLiTCoKGCXsoapdmNUE6+0d5eQyMMy/EW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 15:31:46.0736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c39fcc2-b281-4edf-a891-08d5900a05c5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB3916
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DEZnBEgdqIPZuRMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 22, 2018 at 05:13:58PM +0200, Leon Romanovsky wrote:
> On Thu, Mar 22, 2018 at 03:47:41PM +0100, Dmitry Vyukov wrote:
> > On Thu, Mar 22, 2018 at 3:29 PM, Leon Romanovsky <leonro@mellanox.com> wrote:
> > > On Thu, Mar 22, 2018 at 02:36:55PM +0100, Dmitry Vyukov wrote:
> > >> On Thu, Mar 22, 2018 at 2:20 PM, Leon Romanovsky <leonro@mellanox.com> wrote:
> > >> > On Thu, Mar 22, 2018 at 02:10:21PM +0100, Dmitry Vyukov wrote:
> > >> >> This bug is actively happening several times per day, if such bug is
> > >> >> closed syzbot will open another bug on the next crash.
> > >> >> This bug has a reproducer, why do you think it is invalid?
> > >> >
> > >> > I tried to reproduce it on latest rdma-next and failed, so wanted to
> > >> > start from clean page and see if it is still relevant.
> > >>
> > >> Ah,  I see.
> > >> You can now see the current status on dashboard:
> > >> https://syzkaller.appspot.com/bug?id=d4ac7bfeafac8a3d6d06123e078462ac765415e7
> > >> Yes, it still happens.
> > >>
> > >> syzbot has already reported another incarnation of this bug, you can
> > >> see the link to dashboard in the email:
> > >> https://syzkaller.appspot.com/bug?extid=b8d5eb964e412cfd2678
> > >> and it contains a link to the first version with reproducer.
> > >>
> > >> > Does it still reproduce on latest rdma-next?
> > >>
> > >> syzbot does not test rdma-next.
> > >>
> > >> But can you reproduce it on upstream tree where syzbot hits it? Just
> > >> to make sure, you have ODEBUG enabled, right?
> > >
> > > Thanks for the tip, I added more debug options and returned to try the
> > > repro on clean v4.16-rc1, it looks like I still don't have all needed
> > > config options (SELinux).
> > >
> > >   mount(selinuxfs) failed (errno 2)
> >
> >
> > It seems that you have old syzkaller sources, it now explicitly does
> > not fail on ENOENT:
> >
> >     // selinux mount used to be at /selinux, but then moved to /sys/fs/selinux.
> >     const char* selinux_path = "./syz-tmp/newroot/selinux";
> >     if (mount("/selinux", selinux_path, NULL, mount_flags, NULL)) {
> >         if (errno != ENOENT)
> >             fail("mount(/selinux) failed");
> >         if (mount("/sys/fs/selinux", selinux_path, NULL, mount_flags,
> > NULL) && errno != ENOENT)
> >             fail("mount(/sys/fs/selinux) failed");
> >     }
> >
> >
> > > Can you please cancel my email that closes this bug?
> >
> > There is no such option. The new bug is already created:
> > https://syzkaller.appspot.com/bug?id=6ecd3fdba0501c8843300056375abea0880816d2
> > now if we open the old one, we now have 2 for the same root cause. It
> > will lead to mess.
>
> Still no luck, I'll leave this bug for now.

So, except this bug, everything else is fixed.

Thanks

>
> Thanks



--DEZnBEgdqIPZuRMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkhr/r4Op1/04yqaB5GN7iDZyWKcFAlqzzFwACgkQ5GN7iDZy
WKeP5g//b/HiA2DIE5Gxjlp69N2tpx82adjhR6eKSyvRq+r6mTMFXOdJsb5NytB9
+R5L+8x7bDpL8AMa5abTxNzBgX+CaN1jUSVxRsawpGKcfQRLxoRwhu0WrWEISHsD
0jlzxzJvInhmpsnJzpw6UGfBxYzWaj3TsxB1uMdv9olsPLZhlgmXPBUPhG/Eoexz
JLeLPN+n8cFgOKaBU0xkhK3mHQgm5YO/pZT8rIvOYl7HhdzAOxuqQ0mn/REUA4Dz
PIeiBc6bW+nTHlA9Tt6FH7le7m7TNyjc3iN9Z5YqnP49W2cjmI4OKfEhP1+k78ww
yMfo5J2KNlI1t1mtj5I2PvUeDGyrNzrbA+yz8t2xtIPbH9vMlD/ycFdzptjtq+Z8
PKLdzHoK+uYrDU+xhwP7E1RBt9QI4YfbuRc2Q2sFLsx79JM8uvEv1PLBGTISVY6P
Dd0gcjI0Taa7dr4Yqw4wJzNbzu7KCDEEyXVsFJlwCCuJikgLYiOAgV6CnQl6Mj3N
g/p+2Se/GARhS+FnDyYCDCdJcKBqJMwuj1gDEp9ME9DXZqp0IgcT5qja4lzHNQ/N
RH96ibEBmkdWV35qHorW365mZ2Fti7itJ61ecQFflgOLcrEPxQDADWZyZQRzdKIS
jpzDu2IGV4oZP8D2mmV8fGFtAcHu487bJt+lwBfJljIXaL4mxOA=
=MoRE
-----END PGP SIGNATURE-----

--DEZnBEgdqIPZuRMC--
