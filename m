Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755658AbeDWQrF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:47:05 -0400
Received: from ucol19pa09.eemsg.mail.mil ([214.24.24.82]:39326 "EHLO
        ucol19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754788AbeDWQrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:47:02 -0400
X-IronPort-AV: E=Sophos;i="5.49,318,1520899200";
   d="scan'208";a="681579455"
X-IronPort-AV: E=Sophos;i="5.49,318,1520899200";
   d="scan'208";a="11012227"
IronPort-PHdr: =?us-ascii?q?9a23=3AEbcfHxcU1le1VGh0VqnkH3ALlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc25YB2N2/xhgRfzUJnB7Loc0qyK6/umATRIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfb1/IA+qoQnNq8IbnZZsJqEtxx?=
 =?us-ascii?q?XTv3BGYf5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ7NYCi8mM3?=
 =?us-ascii?q?0u683wqRbDVwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xy?=
 =?us-ascii?q?mp4rx1QxH0ligIKz858HnWisNuiqJbvAmhrAF7z4LNfY2ZKOZycqbbcNwUX2?=
 =?us-ascii?q?pBWttaWTJHDI2ycoADC/MNMfhEo4X4oVYFsBmwChS2BO731zFGmHH206053e?=
 =?us-ascii?q?ovHw7J0w4vEM4BvnnPsNX4Nr0fXfypwKTGzzjOae5d1zfn6IjPdxAsueyCXa?=
 =?us-ascii?q?5ufsrJyUkgCQXFhUiNp4zgJTyV0uANvHab7uF9Uu+vkHMoqxpqrzizxsYjlo?=
 =?us-ascii?q?nJhoUPxlDC7iV22pw5JdK/SE5leNOpFoZbuSKCN4ZuX88vTG5ltDw6x7Ebo5?=
 =?us-ascii?q?K3YicHxIo9yxLCbfGMbpKG7Qj5VOmLJDd1nHdleLWiiBms6UWg0ej8VtWs0F?=
 =?us-ascii?q?ZNsypFjsHAtnAT2BzX7ciKUud98V272TaOygDT8ftIIVw0lKXHK54hxaQ8lp?=
 =?us-ascii?q?wPvkTYAiD6gkD2jK6Sdkk8++io7froYqn+q5OBOIJ5hRvyP6QzlsClH+g1PR?=
 =?us-ascii?q?YCU3KG9eik0b3s50z5QLFEjv0slanZtYjXJd8Gqa6iGAJVzoYi5Aq/Dzehyt?=
 =?us-ascii?q?gYm2IHI0hfdBKIiIjpJUnCIOrkAvenn1SsjDBryujbMb3hGJnNLmbMkK37fb?=
 =?us-ascii?q?Z48UFczgwzwMtQ55JREL4BIfbzVlXtu9zfCx8zKxa0zPr/CNVhyoMeXnqCAq?=
 =?us-ascii?q?uYMKPUrF+J6fsjI+qSa48PvjbyNfwl6uXwjX82h1AdZ7Ol3ZgJZ3CiGPRpPU?=
 =?us-ascii?q?GZbWDrgtcbHmcAphA+Q/DyiF2eTT5TYG6/X6A55jE8EoKmF4bDRpu2jbyHxi?=
 =?us-ascii?q?i7G4NZZmFcBlCLC3foeJ2OW+0QZyKKPs9hjjsEWKC5S4A7yBGusBT3y6J9Ie?=
 =?us-ascii?q?rJ/i0UrJfj1N9y5+3Jix4+7yB7D8OY02uVVWF7gnsIRyMq3KB4uUF91kmM0a?=
 =?us-ascii?q?djjvxaFtxT4/ZJXh08NZ7b1+Z6Ecz9WhrdfteVT1arWtGmATA3TtIszN4Cel?=
 =?us-ascii?q?19FMu+gRDexSqqAqMVlrySCJwx9aLTwmXxJ8JjxHvdyqkhgEcpQtFVOW2lmK?=
 =?us-ascii?q?F/7Q7TCJDNk0mDkKaqb6sc1jbX9Gif1WqOoF1YUAloXKrbRXAQfFHWrdXi5k?=
 =?us-ascii?q?7ZV7+hE64nMgpayc6aLqtFcMHmgktcSPfkItTebHq7m32sChaQ2rOMcI3qdn?=
 =?us-ascii?q?0G3CrDEkgEnB4c8G2GNQckAiehp2LfDDp0GV3zZEPs9PF0qGmnQU8s0wGKc0?=
 =?us-ascii?q?ph2qKo9REPm/yTVfYT06kZtyg7tTV7AlO939bRC9qOuwptZqNcbs0h4F1fz2?=
 =?us-ascii?q?LWqxR9PoC8L6BlnlMedRp4v1/z2BppFIVNitYqrHw0wwpoM66Y001Odyme3Z?=
 =?us-ascii?q?/uPr3bMG7y/Aqga/2e5laL/N+I+6tHyPkisVDqugfhQkYitXVqycNQ2n2azp?=
 =?us-ascii?q?rPBQsWF5n2VxBzvxx7oazKJyow/YXZ0VVyPqSu9DzPwdQkAK0i0BnzUc1YNf?=
 =?us-ascii?q?a/CALqE8AcT/OrIegulknhOgkIJ8hO5aU0OIWgbPLA16m1arUz1Am6hHhKtd?=
 =?us-ascii?q?gumnmH8DBxH6uRhc4I?=
X-IPAS-Result: =?us-ascii?q?A2B9BwCyDd5a/wHyM5BbHQEBBQELAYMYK4FbKINqlHpFA?=
 =?us-ascii?q?QEBAQEBBoEjgQ+GbId9hg82hEACgmchNxUBAgEBAQEBAQIBayiCNSQBgkkBB?=
 =?us-ascii?q?SMEUhALDgoCAiYCAiE2BgEMBgIBAYJYghsDCA2qB4FpM4RYgjINgSuCOYEJh?=
 =?us-ascii?q?wOBDIEHgTKCaIJPhSSCVAKXRywIi0OCdwaMTiuJS4dcMiKBUisIAhgIIQ+Cf?=
 =?us-ascii?q?oIgF44zIzBiAY9KAQE?=
Subject: Re: [PATCH 3/3] selinux: provide unix_stream_socketpair callback
To: David Herrmann <dh.herrmann@gmail.com>, linux-kernel@vger.kernel.org
Cc: James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        teg@jklm.no, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com,
        davem@davemloft.net, netdev@vger.kernel.org
References: <20180423133015.5455-1-dh.herrmann@gmail.com>
 <20180423133015.5455-4-dh.herrmann@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2710a66f-8a40-3a9a-7b50-e4279c53ebcd@tycho.nsa.gov>
Date: Mon, 23 Apr 2018 12:48:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423133015.5455-4-dh.herrmann@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/23/2018 09:30 AM, David Herrmann wrote:
> Make sure to implement the new unix_stream_socketpair callback so the
> SO_PEERSEC call on socketpair(2)s will return correct information.
> 
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>  security/selinux/hooks.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 4cafe6a19167..828881d9a41d 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4905,6 +4905,18 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
>  	return 0;
>  }
>  
> +static int selinux_socket_unix_stream_socketpair(struct sock *socka,
> +						 struct sock *sockb)
> +{
> +	struct sk_security_struct *sksec_a = socka->sk_security;
> +	struct sk_security_struct *sksec_b = sockb->sk_security;
> +
> +	sksec_a->peer_sid = sksec_b->sid;
> +	sksec_b->peer_sid = sksec_a->sid;
> +
> +	return 0;
> +}
> +
>  static int selinux_socket_unix_may_send(struct socket *sock,
>  					struct socket *other)
>  {
> @@ -6995,6 +7007,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
>  
>  	LSM_HOOK_INIT(unix_stream_connect, selinux_socket_unix_stream_connect),
> +	LSM_HOOK_INIT(unix_stream_socketpair,
> +			selinux_socket_unix_stream_socketpair),
>  	LSM_HOOK_INIT(unix_may_send, selinux_socket_unix_may_send),
>  
>  	LSM_HOOK_INIT(socket_create, selinux_socket_create),
> 
