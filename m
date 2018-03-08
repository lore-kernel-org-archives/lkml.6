Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935072AbeCHNim (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 08:38:42 -0500
Received: from mail-ve1eur01on0061.outbound.protection.outlook.com ([104.47.1.61]:36040
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754990AbeCHNij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 08:38:39 -0500
Date: Thu, 8 Mar 2018 15:38:30 +0200
From: Leon Romanovsky <leonro@mellanox.com>
To: Doug Ledford <dledford@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the rdma-fixes
 tree
Message-ID: <20180308133830.GU15340@mtr-leonro.local>
References: <20180308164058.2ad5a158@canb.auug.org.au>
 <20180308060920.GQ15340@mtr-leonro.local>
 <1520515725.3126.88.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RtGa12sjXv8gVUZO"
Content-Disposition: inline
In-Reply-To: <1520515725.3126.88.camel@redhat.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Originating-IP: [213.57.247.242]
X-ClientProxiedBy: AM5PR0701CA0007.eurprd07.prod.outlook.com
 (2603:10a6:203:51::17) To VI1PR0502MB3920.eurprd05.prod.outlook.com
 (2603:10a6:803:11::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8c25aae6-9568-4c88-6390-08d584f9e557
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0502MB3920;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB3920;3:YnPFklnYuiNRUR3qXbZCkndLH/lan5eCIz6cqDfYsNqt8zA1ZHrh0AEnQnAspaEljl2nv4rc28pHrC3UkJVk0GFB81IMmyzuGENBXB8Ce5Txd0RhW8hKmPwvV6433EKn14aoUBY9KsO4s15R1L3PttF/CFcwNEg8qMCn27FsqaDADqDlhf8e75jhejO4qyXy+4/+/+sTVOaAmsJR5k1i2HPp7KoLTjxlmGvOEDtDRAql7QaID9TROrPAfSJfCbac;25:c9UxbS3vwwLEuiS2WpK+dpjS6mG8S5RVwHr1zS+w0Qla8/z4RG3j1/1kNEa/iOHtY9v7MtGiR1s4XG8LMUqqD+OGJ2WF2VOsvyPNtkVphAwUDEBhJd3g5qabYg3PLIFF+4H96Rn/brd68gbyHaxEMf5nplrQ11r5UNkBY8OMcZCKqbCe5s9UTYa3WSjhcdGtGATLmS7MqGBy0tvhAguX7Xf9gHbJ3jswqz4ie2rEV/3Uy41kc6vL5QUf0MM+AzhM5OXGGyq9FMrT62ZP/ZsPuppzF/HTTiBrSaJJQtDWSs9Gc8up3mpmAyyThh03JwjqcBgYMRnBGTdbUfda1FkJwA==;31:16eMOtRuFVMGAq7ILtUcIJd/7lSrlFGSr24dyD2OsoLJ/MdRm5OJLzJ2QtCInKbqje3rfZ8sAm2AnHxNuaGP23fusiUGOKranTefv85PLIflN/TUmF98Kn9dBjvN/Ujj+KWTI1sKP27mNimc6RP6/bILxjhgn+GCi2pnAznXNlK+YcATP19r50T/Yn3diMck1FQM9f77nWvx7nyr880ZWWOJDjfeWsFkf9kFAdoXbEM=
X-MS-TrafficTypeDiagnostic: VI1PR0502MB3920:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB3920;20:gNP7ycYzpDXqYuaTrUGzs5Fcf3JqesGWU2nXZWcEcp+4Wf8V+0OQHWW4J8oi2kDHu9Oywea8RfHX4iRY9WefftR3MU5ItZcxsxn+L7VG5crjztKd1wUjA5QWgXBPmNVB9BydUr8O5I+3DzYIS9yEawSqv8QrQo+uVyxfNw4W0ixngcONJ/dG3zfcalmsoONsyzWq6FJfR5k8cDHjHkTBSBoRZMaUb+TkPwPRqDh1tFCAeGEuG1KbRVvFNmTEgNqLNALzId0O/gY3aiH9AwTGUowlS21hK4JGMJZKskEOyR4VNOViLFpEzl6cuItzVWrZKNz/0p7OxtTUCeu1DyAmDGZ0/uoPsw+dvf9cy26aBuo0si5GPn1lIQe9Vezn6VRUHNgtjDVclt1QMsgiqhPFSCXPlC/aGZVIPWXsq589lxorODl+joFG480CJ3ofKRmrDpiwXchLoa3wpK3Yrcdxm7VMgAiE6froRmCsyGVmVa8dL1pPmMU4CNDY/j9iIj89;4:tdsTKQE7RH78NPzDjU9L4QZJ4Il/Gp9O2wJV//B1faLXhMifpAfL5xxbpKA77Cg/buegYbiZCwceYzQ/MaBnvc1UYBKMQul7VSCoX+ZhQhWNzAyJ8N4zXakmdbQpnWguLT9qwHnNHoeqXeKruqlol9WEsVWpo05E4t6LjmDK9BaFHFYgNvjeUFK9V+HqnV+1ZqUDHj/np8oSDV540mAI9PlVrOCBgKpGbVF80or47QmJR4/ksCZs2N9kSgHD/cNJNrNSHJlaG3Gdrf5ktq8wETBYOMZmRDplnDax614jQp113xJS9GQkR8iLiKWsCPu1
X-Microsoft-Antispam-PRVS: <VI1PR0502MB392060A8360A806B6FD286F7B0DF0@VI1PR0502MB3920.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231220)(944501244)(52105095)(3002001)(93006095)(93001095)(6055026)(6041288)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR0502MB3920;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0502MB3920;
X-Forefront-PRVS: 060503E79B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(376002)(366004)(39860400002)(346002)(396003)(189003)(52314003)(52024003)(377424004)(53754006)(199004)(2950100002)(5660300001)(86362001)(81166006)(81156014)(575784001)(6246003)(7736002)(305945005)(84326002)(97736004)(6306002)(229853002)(8676002)(98436002)(6666003)(33656002)(6916009)(6486002)(105586002)(53936002)(9686003)(76506005)(44144004)(386003)(33896004)(186003)(4326008)(68736007)(106356001)(966005)(25786009)(21480400003)(478600001)(52116002)(6116002)(58126008)(54906003)(16586007)(26005)(16526019)(3846002)(66066001)(2906002)(1076002)(8936002)(6496006)(76176011)(316002)(63394003)(18370500001)(2700100001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3920;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0502MB3920;23:GjSllx0U3eeRjljMHnfFmDz+gb1UBcsjimwJ8Pp?=
 =?us-ascii?Q?mrKdRNQobUkf6xDMxnln+o4vHnMTrMHBcapB99EWOl2g7AM6KWoG1Z34PXV6?=
 =?us-ascii?Q?97Iz860TLUR7hFgJVkBgLxp0mGH9/a82Ys42wPOtS58er3318gBzTX5yGPmR?=
 =?us-ascii?Q?WgTSgRWFfQdDpFSVPHsTxglECVGEJk5682+NmTQs1hot4Mr6hYHvSckPKhv9?=
 =?us-ascii?Q?vqQQKOz/8WAKKtmTiVTreTAhPDjRNUgK7whOE7FFmCdAnAGjBa8OG9uGw1rq?=
 =?us-ascii?Q?sR/DfCfEcl79kKCcATL1JwhwfStIdUh7r1g9i2eTz+YpdMUeqPgOAkF/32pO?=
 =?us-ascii?Q?DjC09SL6C14rHaHI6ZmFnkQNGE2Q9n7puqLS7620RRbswtH48a33g3TUaiQR?=
 =?us-ascii?Q?yc8sJDgbNp32sxnBDmcucp0VkOzmcF23NVWNJ0uB1PRZtlRQIqJqS62Pnf6I?=
 =?us-ascii?Q?wp/XYGrOLSD3UuxcK5RqlsLBSzQ0aIXFWAzu4FeR9xu+aILgUNBYWgwOIcXZ?=
 =?us-ascii?Q?JF7nN6r7OS+EKSDa7PrhISb6SHSvDX0a1UvGGmtm6tMqSnbMNWrEAsTb+tcl?=
 =?us-ascii?Q?cr0VXVde2ELl7GNVdiAbnEE16cPgmCW7trLZR+peSO9//gyGvqem9juFINkV?=
 =?us-ascii?Q?kBbIS22h1Jz1NnLB/zWobep+KyUy1FQOOVuJKfqrFDl38QZALKaOvFEJb+iM?=
 =?us-ascii?Q?6Dbm+UogD/2/ydnEwNYvRhCskk61M0zt+bhXIZMbXGK8mYMQ7Sd3dWIoUAoR?=
 =?us-ascii?Q?s/I0KFdDpaLh8dwGrSZlc+1s7b4WP+v1ktwI4fMuJYJCXc5HR8fjWUpwWwT0?=
 =?us-ascii?Q?1hBnlZy2GS6svKxXpgI+qv/8S3IT3lXOSHh2txu+ceNKd3i4kDdR/7qo7WXJ?=
 =?us-ascii?Q?+OMuyUQcR6HfW1Q+4wp0jDvJQgW8oGmHM2Hb2/Gny9isFa7oGHRKixUbH6jo?=
 =?us-ascii?Q?wR1Jvcf1K/oXvetd0Vvo+i9ojxQZoefxmYXA+WRLibjq1COi/8RbY7+c9fja?=
 =?us-ascii?Q?9GphvscGzKugHSlccyMaS2sNCSI7TL/V3FfabMgo0BEwhjs38COOQ2TZM9GL?=
 =?us-ascii?Q?98htT2vssE/BZ7mWhj2f64DkVeTdQ59mCr1YJrYbAnS6URG2q/rqyf/5nvp+?=
 =?us-ascii?Q?SE5jxvnrjGsFuktAiLyZImw7NDfYb+j4kf7rayxnMjcRRVJGalCNt5XTRbwv?=
 =?us-ascii?Q?8h8NfhPorBxO3G5oJfmWUpzBf51YpbMy94oIqPZ7EO54K2pfleStT5xEPxQK?=
 =?us-ascii?Q?pbycodY8sP8l/77LBMS2CkvSGyjTYcSXUWR5Fwo6RiW9tV4ZhqBk3pEdOM+e?=
 =?us-ascii?Q?kK6z7MUil08NaUhWbnuVse7V4eB8+jzUgyFWa3wJ3RFyEMqKAtYr9yFgZ0Lr?=
 =?us-ascii?Q?9egES/VPe4AhmhAOiyuWdyCHDqsd0cTXmBw6Qurhhq0cY8eqnn5xf0T2I+iJ?=
 =?us-ascii?Q?y58cJXKgCv1dwXo/Tkx44zG6STRO8vPT2RJlWQ48opA/Y934gH4Z6?=
X-Microsoft-Antispam-Message-Info: VXYSePhiT9a6At7cOwJeZmw/MjxpAwK3/bOkiluvZGDeGyCv8wXUtOv5aNE3FZhMEZ2lRCnl9OFST4o94DbsF8Q4PZYl4CX8AGifmsnS3MkKWbJ1JbrbB+XVtqluYjslqno5qXoGQHtxMt6HLx49slTCoPugVH2zHi9ceizpgdxKj4Zq/VpdllncLtlktV97
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB3920;6:20iBD/++TEh4p2QrRITtMpOIeePlfZTuQHXRBWyuMU4mOAujdB6jjvPKNKunDYRZuT3I67uY3G+h8b5OsBCQMW+8K8tRRZPNGFuulAOWNka7EvsbqknULU0V+JILvUOVySjJ1OE2XvAM6C8JJc+ySJJzAi67QdisKNdsAi8tDheUDIkWk8/E9gVVY2t/EpgfbhUV3fF9jimpputBFM9bjDxFjsdg4P//jU8ZpPYUgylEd80gSqE+OUvoOxugSCIbV1cSc33iEP5ClpsEKfZDbWCKxxIOfXYoFb7dC3sxZYz1wpGcCvhF3w1JKQwNKaneLj5R76/tS0Ez1GR83WkRvIfvZkykptIiyuK7udWzK4k=;5:jNbzd0Q+lwsA+EFFAlah/BgZi4v+TFfxhKjMId2kgnv7gh+eBgJ4ZWcBuSP9BNsXvMK/bHOHXgSkAOITgnPC5bIUGj6uT4v2xMKu8YnAI9ipq05HfOJa35II/9yU9zZ0N+h9v9kbDDmyHqfc9po3XbU6F4DqPOQtEpwRQVTyy4M=;24:qbF5MF4k1Ou3v3yswZO0FPBkENbEI1SW+nKNx94VR8ei26Kb3GdVIalmGNMf6Q7flopWdsFGNHiqZgOpTCYMJrKOoAIPxr457U5fn9+Iswo=;7:mkO0BlqbqL0VMwoznE9zMSzhU9B1gB3moFVnI9sxsNiO/t/rUqj8EoSbexwl8Wa55v3vIANzlSgUgNYHC7/OfWVSRZ4oTFRLdg4LZ/cstbDq5AIexlMSyQo+bYv8jS8BlTH6eWTcLBXWGbWeOS5Iqkig7Wtslu2AL/vHNcDLGCnUPQ4wo2FEQUWvEZgjtbBMxsiCiTkY2UJVU6U8PE+a9gbsZ1WRAoPdQlSWkzPvK451McLWWXsLExb+uEIuWlAV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2018 13:38:36.9569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c25aae6-9568-4c88-6390-08d584f9e557
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3920
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RtGa12sjXv8gVUZO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 08, 2018 at 08:28:45AM -0500, Doug Ledford wrote:
> On Thu, 2018-03-08 at 08:09 +0200, Leon Romanovsky wrote:
> > On Thu, Mar 08, 2018 at 04:40:58PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > Commit
> > >
> > >   aa0de36a40f4 ("RDMA/mlx5: Fix integer overflow while resizing CQ")
> > >
> > > is missing a Signed-off-by from its author.
> >
> > Doug, something went wrong with your scripts
> >
> > In patchworks it is with SOB and lengthy commit message:
> > https://patchwork.kernel.org/patch/10264089/
> >
> > In the tree, it is cut:
> > https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=for-rc&id=aa0de36a40f446f5a21a7c1e677b98206e242edb
>
> I use git am -s <mboxfile> to bring the patch in, so this usually
> indicates that there was something wrong with the email and it caused
> patchworks to improperly parse it.  Sure enough, when I look in
> patchworks (https://patchwork.kernel.org/patch/10264089/, the exact link
> you listed above so I'm surprised you didn't catch this), patchworks
> parsed that separator line you put in the commit message:
> ====================================================================
> as the end of message and start of patch.  So, in patchworks, that line
> and everything after it is considered part of the patch and not part of
> the message.  So, when I download the mbox file, patchworks placed this:
>
> ---
> 2.6.12
>
> at the end of the truncated commit message, so git am would also ignore
> everything after your separator line.
>
> Anyway, I've hand edited the mbox file and I pushed a rebased version of
> my wip branch.  However, during the night Jason must have moved my
> wip/for-rc branch to the official for-rc because it's there now, so the
> only way to fix this (that I know of) in our official for-rc branch is a
> rebase :-(

It is harmless and not worth of rebase at all. Leave it as is. Thanks Doug.

>
> FWIW, be careful using those big separator lines like that.  They can
> and, as you see here, do trip up the automated tools sometimes :-(.
> Would be better to just not put a guard around the copied in stuff.

I'll do and will clean it from my next patches.

Thanks again.

>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD



--RtGa12sjXv8gVUZO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkhr/r4Op1/04yqaB5GN7iDZyWKcFAlqhPNUACgkQ5GN7iDZy
WKdLCA//e7iVwDHNgfe7HeA5CoGWQsR7W0cXjW4SHJ/wXpB2piA0QvMBbjNpD9Fi
2W986cFko5KS3pcdy2Fc684BOc1nljgZad/ybKoUAkuyQnhUKumQIR7aAQrHypgx
YT/2iD2Zr2/LnTwqWFEoAw7bWg93gWfpre86aGfhAZAGEe9Ia0mBTQjoUD3H89+G
ZiM1p7lUnh6ZLgzejRyNlPYXIzHVn1HhiYY+kIACpAdkiDHiicFglZ/ZWMOUVI0P
+xoBIcvNutuliTY7vZUm6XAYccMfkatjByQo44t301Anw4uQbpDzl2OYYZitLlab
jQ0TW3FNkqGZDzIslqzQkdj6xwKLSqZ/wqyMNkkfWkp93QbW/TSgM+SilUDmwr7n
gmYbnzg7/FkUWwXvpmrUbwPB30mAB82yoBeqR8+r5b9jaleEz5lZeRrMhYnw/NH4
qj6Er0I8YN/tdcJZZdD8xiDHPMoi0MHykL69dYQtPXWTn2cBeaNCz1yz8B3CXlB0
JhhwALEEoMRJNYir9HnqYXjjHzjSidslyJm7Me3EuIKkz+GWgpA4Y3qd7dOAtK9o
VgPSMe90dybYAeN6UGPKRcqgPy1gQGMOttfUj9ft3Ql6vowkg231cmB/wcesGdF+
MEPDyJbzaH7V54A0Pxci7bLiz8yP5DWExtw3bCSc4YWtwlsbrYM=
=6CaH
-----END PGP SIGNATURE-----

--RtGa12sjXv8gVUZO--
