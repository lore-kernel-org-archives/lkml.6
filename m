Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeBTTFr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 14:05:47 -0500
Received: from upbd19pa09.eemsg.mail.mil ([214.24.27.84]:38901 "EHLO
        UPBD19PA09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751785AbeBTTFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 14:05:45 -0500
X-IronPort-AV: E=Sophos;i="5.46,540,1511827200";
   d="scan'208";a="9572133"
IronPort-PHdr: =?us-ascii?q?9a23=3AXRQP2xfGqB2JgAJBx6bmo8n0lGMj4u6mDksu8pMi?=
 =?us-ascii?q?zoh2WeGdxc2zZxeN2/xhgRfzUJnB7Loc0qyK6/umATRIyK3CmUhKSIZLWR4BhJ?=
 =?us-ascii?q?detC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBxrwKxd+?=
 =?us-ascii?q?KPjrFY7OlcS30P2594HObwlSizexfb1/IA+qoQnNq8IbnZZsJqEtxxXTv3BGYf?=
 =?us-ascii?q?5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ7NYCi8mM30u683wqRbD?=
 =?us-ascii?q?VwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xymp4rx1QxH0li?=
 =?us-ascii?q?gIKz858HnWisNuiqJbvAmhrAF7z4LNfY2ZKOZycqbbcNwUX2pBWttaWTJHDI2y?=
 =?us-ascii?q?coADC/MNMfhEo4X4oVYFsBmwChS2BO73yTFGm3/407M03esjHwHJwAsuEN0Bvn?=
 =?us-ascii?q?nPsNX4Nr0fXfyvwaXUzzjOae5d1zfn6IjPdxAsueyCXa5ufsrJyUkgCQXFhUiN?=
 =?us-ascii?q?p4zgJTyV0uANvHab7uF9Uu+vkHMoqxpqrzizxsYjlonJhoUPxlDC7iV22pw5Jd?=
 =?us-ascii?q?K/SE5leNOpFoZbuSKCN4ZuX88vTG5ltDw6x7Ebo5K3YicHxIo9yxLCbfGMbpKG?=
 =?us-ascii?q?7Qj5VOmLJDd1nHdleLWiiBms6UWg0ej8VtWs0FZNsypFjsHAtnAT2BzX7ciKUu?=
 =?us-ascii?q?d98V272TaOygDT8ftIIVw0lKXHK54hxaQ8lpwPvkTYAiD6gkD2jK6Sdkk8++io?=
 =?us-ascii?q?7froYqn+q5OBOIJ5hRvyP6QzlsClH+g1PRYCU3KG9eik0b3s50z5QLFEjv0sla?=
 =?us-ascii?q?nZtYjXJd8Gqa6iGAJVzoYi5Aq/DzehytgYm2IHI0hfdBKIiIjpJUnCIOrkAven?=
 =?us-ascii?q?n1SsjDBryujYMb35GJrNNHnDkKz6cLZl8UFc0gszzctH55JQEL4OPOz8VlX2tN?=
 =?us-ascii?q?zCAR8zKxa0zPr/CNVhyoMeXnqCAreDP6PPtV+F/fovLPORZI8RoTr9Lv8l5/n0?=
 =?us-ascii?q?jXAng1MSYa6p3Z4PYnCiAvtmO1mZYWbrgtoZHmYFoBMyTOjriF2ETD5SaG++UL?=
 =?us-ascii?q?wz5zEnFo2mF4HDSZqpgLGawCi7H4ZWaXxBClyWDXjocICEUe8WaC2OOs9hjiAE?=
 =?us-ascii?q?Vb+5Ro8l1BGushL6yrV+IurP5CIXqY/j1MJ05+3PlRA+7Dl0D8OA3GGQS2F7gH?=
 =?us-ascii?q?gFRyE53K9hu0xx0FSD3rZig/xeC9NT4+lFUgAgNZ7T1+Z6Ecz9WhrdfteVT1ar?=
 =?us-ascii?q?WtGmATA3TtIszN4CekV9FMu4jhDFwSWqB6QYl6KEBJMq6KLQxXvxKNhny3bAyq?=
 =?us-ascii?q?Yhi0MqQsxVNW2pnqR/7RTcB5bVk0WFkKanbaAc3C/L9GeewmuCpVxXUAlsXqje?=
 =?us-ascii?q?Q3AfaVXZrc7j6kPBUbCuE7InPRVFycKYLatKcNLph01cRPj/INTef36xm2CoCB?=
 =?us-ascii?q?aL3LyMaZTle2MG3CXeCEkJiBwc/XedNQciASetuX7RDDtrFVj3eUPj7fF+qG+n?=
 =?us-ascii?q?Tk8z1wyKbkth17up+h4Pn/OcTv0T3qkftSc/pDV7Aky908jVC9WevQphertTYd?=
 =?us-ascii?q?cn7FdAz2LZuBR3Poa8IKB6ml4ebwN3slvs1xptD4VPj9MqoGkkzQZoLKKXzFZB?=
 =?us-ascii?q?eC2E0pDwILLXLHL//B+qa6HM21He1Mya9bsI6PQ9s1/jph2mFlI+83V71NlYy2?=
 =?us-ascii?q?eT5pLQDAUJT53xTl069xx0prHceCU94Z3b1WF0O6murjDCw84pBPciyhu4ftZf?=
 =?us-ascii?q?N6OEGxXoE8ABA8iuKeoqm0Wmbx4eIuBS8rA7P9+8e/uHw6GrOfxsky6hjWRC+I?=
 =?us-ascii?q?p9yF6D9zJgSu7U2JYI2+uY3gycWDrniFeuqMb3lp1AZT4MHmuz0y7kC5BNZqdq?=
 =?us-ascii?q?Z4YEFX+uI9GrxtV5n5PiQWRY9Fi+CF4dwsCpYxySYEHm0gFKyEsYv2StmTGkwD?=
 =?us-ascii?q?xsjzEpsq2f0TTQw+TjbhoHPXVGRWh8glfqIIi0kcoWXEypbwgviRuk6lz2x69B?=
 =?us-ascii?q?pKRwNWXTXERIdTDsL25+SquwqqaCY8lX5ZMoqSVYSv+xYFGaS77hpBsayTnvEH?=
 =?us-ascii?q?dZxDA+bzuqoIn2nwRmiGKBK3Z+tGbZdttzxRfY4tzTWORR0SAdSSZkiDnXHUSz?=
 =?us-ascii?q?P96z8dqIkJfDt7P2a2X0apRJeDKj7oSGuDGy+Wx3AlXrg/mwndvrCwES2i7g3N?=
 =?us-ascii?q?4sXiLN+lK0KKmtn5y3Le99NmBuGl76oYIuGpl3upkhmJYKn3Mdg8PRtVMD2Vny?=
 =?us-ascii?q?K9ITjbz/dn0lVzMNwsCT5AnjxV0lKWiGgZ/6ADHV69Fna5GQb3kZ3ys76YgeAb?=
 =?us-ascii?q?2S4JRNhy15qBy0oFSVKcJ6lH85wP0i7HMLy7UTvwAFyiybDrQfDA9eMDC601yt?=
 =?us-ascii?q?7tW/5JdQZG+1Oeyi00p3h/ilDbefskdCXnvlPJYoGGl76cApdBru13v69oHtfp?=
 =?us-ascii?q?H7asgZuwHcxxzHleJYNLo1ifxMgyd7bya1n3QgxvVzqBdL0Jq6tY7Pf2dk+a+i?=
 =?us-ascii?q?RAEeMzbwasgT8zfFgqNXn8LQ1IeqSMZPADIOCaD0QOqoHTRajvHuMwKDAXVosX?=
 =?us-ascii?q?uAMabOFg+YrkF9pjTAFI79ZCLfH2UQ0dg3HErVH0dYmg1BGWxgxpM=3D?=
X-IPAS-Result: =?us-ascii?q?A2CyAQDObYxa/wHyM5BcGQEBAQEBAQEBAQEBAQcBAQEBAYM?=
 =?us-ascii?q?iLYFWKINomCxFAQEBBoE0gReYX4VFAoJsWBQBAgEBAQEBAQIBaiiCOCQBgkYBA?=
 =?us-ascii?q?QEBAgEjBFIQCw4HAwICJgICVwYBEogCghQFCK0ugW06hBgBaYN6ghMBAQEBAQE?=
 =?us-ascii?q?EAQEBAQEBASGBD4N/giiBD4VehGwhFoMXgmUFklKBFpBNCZYKlEeZWzYigVErC?=
 =?us-ascii?q?AIYCCEPgn2CVBwZgTIBWCM3ilAFgkgBAQE?=
Message-ID: <1519152994.14218.15.camel@tycho.nsa.gov>
Subject: Re: [PATCH v3 15/15] selinux: delay sid population for rootfs till
 init is complete
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Taras Kondratiuk <takondra@cisco.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Rob Landley <rob@landley.net>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James McMechan <james.w.mcmechan@gmail.com>
Cc: initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, xe-linux-external@cisco.com,
        Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>
Date: Tue, 20 Feb 2018 13:56:34 -0500
In-Reply-To: <1518813234-5874-19-git-send-email-takondra@cisco.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
         <1518813234-5874-19-git-send-email-takondra@cisco.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-16 at 20:33 +0000, Taras Kondratiuk wrote:
> From: Victor Kamensky <kamensky@cisco.com>
> 
> With initramfs cpio format that supports extended attributes
> we need to skip sid population on sys_lsetxattr call from
> initramfs for rootfs if security server is not initialized yet.
> 
> Otherwise callback in selinux_inode_post_setxattr will try to
> translate give security.selinux label into sid context and since
> security server is not available yet inode will receive default
> sid (typically kernel_t). Note that in the same time proper
> label will be stored in inode xattrs. Later, since inode sid
> would be already populated system will never look back at
> actual xattrs. But if we skip sid population for rootfs and
> we have policy that direct use of xattrs for rootfs, proper
> sid will be filled in from extended attributes one node is
> accessed and server is initialized.
> 
> Note new DELAYAFTERINIT_MNT super block flag is introduced
> to only mark rootfs for such behavior. For other types of
> tmpfs original logic is still used.

(cc selinux maintainers)

Wondering if we shouldn't just do this always, for all filesystem
types.  Also, I think this should likely also be done in
selinux_inode_setsecurity() for consistency.

> 
> Signed-off-by: Victor Kamensky <kamensky@cisco.com>
> ---
>  security/selinux/hooks.c            | 9 ++++++++-
>  security/selinux/include/security.h | 1 +
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f3fe65589f02..bb25268f734e 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -716,7 +716,7 @@ static int selinux_set_mnt_opts(struct
> super_block *sb,
>  			 */
>  			if (!strncmp(sb->s_type->name, "rootfs",
>  				     sizeof("rootfs")))
> -				sbsec->flags |= SBLABEL_MNT;
> +				sbsec->flags |=
> SBLABEL_MNT|DELAYAFTERINIT_MNT;
>  
>  			/* Defer initialization until
> selinux_complete_init,
>  			   after the initial policy is loaded and
> the security
> @@ -3253,6 +3253,7 @@ static void selinux_inode_post_setxattr(struct
> dentry *dentry, const char *name,
>  {
>  	struct inode *inode = d_backing_inode(dentry);
>  	struct inode_security_struct *isec;
> +	struct superblock_security_struct *sbsec;
>  	u32 newsid;
>  	int rc;
>  
> @@ -3261,6 +3262,12 @@ static void selinux_inode_post_setxattr(struct
> dentry *dentry, const char *name,
>  		return;
>  	}
>  
> +	if (!ss_initialized) {
> +		sbsec = inode->i_sb->s_security;
> +		if (sbsec->flags & DELAYAFTERINIT_MNT)
> +			return;
> +	}
> +
>  	rc = security_context_to_sid_force(value, size, &newsid);
>  	if (rc) {
>  		printk(KERN_ERR "SELinux:  unable to map context to
> SID"
> diff --git a/security/selinux/include/security.h
> b/security/selinux/include/security.h
> index 02f0412d42f2..585acfd6cbcf 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -52,6 +52,7 @@
>  #define ROOTCONTEXT_MNT	0x04
>  #define DEFCONTEXT_MNT	0x08
>  #define SBLABEL_MNT	0x10
> +#define DELAYAFTERINIT_MNT 0x20
>  /* Non-mount related flags */
>  #define SE_SBINITIALIZED	0x0100
>  #define SE_SBPROC		0x0200
