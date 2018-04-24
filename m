Return-Path: <kernel-hardening-return-13121-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48qBwFBSN9XZ/GsgQ2cF2zSlX+8zifWDqp4263MvfYOfoLvsIzy+8EsDBFySs3U6aLZ419I
ARC-Seal: i=1; a=rsa-sha256; t=1524600117; cv=none;
        d=google.com; s=arc-20160816;
        b=ZN8fq+KHN9DCzVQiL6rcOb0ZbP8+gf4+zqs8zFSCJYqB9+glaKC1jlYwOE1AzJO9cS
         Ok9mIA0yZKgFMht0VgVcjNdVMUBtm1cDsZj6SZLYf+FRSvDltOQjav/RkTrs3pkl0MjT
         +TLbQfsb8GH7qBhZsWGgI0TW/WRZDQtrTb5mHXIqJwFv8HccrgL2LiZw0zYrbRs/XIQA
         BG/c5e1eBZV77LW8l1rfh+JxjANHlA7+0KyDI3QSi0JzHxsVGCquo+CYsrdn0aOE4GBI
         lKtiEek88eskqamTwupU9DZkO0EArXZEjU/g7niEDksrXRnRjLtfDCctr0UCZTgJf9eg
         rGCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :ironport-phdr:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=BTvCIM8twtp2CtnWbXekyDhnRepoPBIqVZ4flXQSvuE=;
        b=E6hC/khjkFqELn+H+3LcTFmP2NQ1AtHdSDLg5M0Jd83Njs0LOzoP6cbsw8PpHfwCuz
         kxmm9NfizCxN1OP8G8GgyMgf1hfov7OjCs1mjWCNoSjmqqM6hZjHtDw++1dDkCDstflp
         wn28R07YfPFCwNIrxRn0iqINlvwmHS3EMNsQh3JSHnwbJ8hzLZqMKLKHMRN4MbIXz10+
         HhMoqN6ML8ISV6aiKHIYVf1+a6OXzPZrFtsSpErJxwOLaGQrnyct/DSwKPIU/xfHm0Dv
         ee7rTS3oz43WjCQlRLe5SiKSHazI/kXBv+8ZK77XFJMmpH3achdmoJSE5SBsU43zOSdb
         3yOw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13121-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13121-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13121-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13121-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-IronPort-AV: E=Sophos;i="5.49,323,1520899200";
   d="scan'208";a="11040492"
IronPort-PHdr: =?us-ascii?q?9a23=3AueJv+R0XHcAlDKyismDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesRK/rxwZ3uMQTl6Ol3ixeRBMOHs6kC07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwtFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QKsqUj?=
 =?us-ascii?q?q+8ahkVB7oiD8GNzEn9mHXltdwh79frB64uhBz35LYbISTOfVwZKPdec4RS3?=
 =?us-ascii?q?RHUMhfSidNBpqwY5YTA+YEO+tTsovzqEYUrRamGAeiGu3vxD9LiHH406I13O?=
 =?us-ascii?q?YuHh3J0gE7A9IDsm7ZoMnpOKocU+24yrTDwzXZb/NR3Dfw8JXGcgw/rvGUXb?=
 =?us-ascii?q?J/b8zRwlQyGQPAlFqQrYjlMC2V1+8QtGWb9PdvVfm0hm47qwB+vjivxsA2ho?=
 =?us-ascii?q?nPnYIa0ErI9Sp+wIYrPNC1TlNwb9CjEJtVrS6aNo12T9skQ25yvSY11LwGtY?=
 =?us-ascii?q?S8fCgQx5QqwQPUZf+fc4WQ/x7uW+mcLS14iX54Yr6zmRm//Va6xuHhUMS/zU?=
 =?us-ascii?q?xEoTBfktbWs3AAzxnT6s+aRfRj5kqhwjOP1xzL6uFDPEA0ibLXK54/zb40kZ?=
 =?us-ascii?q?oeqVjDETXsmEX3ka+WbV8o+vSo6uv7YrXmoYWQN4lohQHlLqsigMm/AeU8Mg?=
 =?us-ascii?q?QWXmib//qz1KH78EHkT7hHgec6n6nEvJzAO8gWqbC1DxVI3oo77hawFTam0N?=
 =?us-ascii?q?AWnXkdK1JFfQqKj5P0NFHVO/34Efe+jEiskDds3fzGOKbhDY/XInjMl7fhY6?=
 =?us-ascii?q?5x61RAxwor0dBf+5VUB6kAIPL8XU/xrsbUDgQlMwyz2+bnEM9y25gRWWKKGK?=
 =?us-ascii?q?CZMafSvUWU6eIoJumGfJUVtyrlK/g5+/7uimc0mFEcfamt2ZsWaGu1HvVgI0?=
 =?us-ascii?q?WXe3rjmMoOHnkQsQUjVuDqj0eCUTFLbXaoQ608/i07CJ6hDYrbRYCinqKO3D?=
 =?us-ascii?q?ynEZ1RYWBGCUuBHmvod4WeXPcMbSOSItJkkjAeUrihUYAh3wm0tADm07pnMv?=
 =?us-ascii?q?bU+ioAuJL7ztd1+unTmAoq9TNuEsSd13iBT2RznmMPXT85wrpzrlB6yleGya?=
 =?us-ascii?q?J4meBXFcRP5/NVVQc3LZvcz+x9C9/uWQLBecyESFW4TdW8BzE+UNYxz8UJY0?=
 =?us-ascii?q?ZnFNWolgrD0DayA78Ji7yLA4Q5/b7b33jrPMly1WrG2bIlj1goRMtDL2umib?=
 =?us-ascii?q?Bj9wLLHY7Gj12Zl7q2daQbxCPN8H2MwnGVs0FfTA5wTb7IXWoBaUTLrdT2/F?=
 =?us-ascii?q?/CQ6WyBrQgNwtL0dSCJbdSat31kVVGQ+/uN8nEbGKvmme/GA2Fxr2WbIrtfm?=
 =?us-ascii?q?Ud2z/dB1MFkwAP53qJKQ8+BiK5qWLEEDNuDU7vY1/r8eRmsnO7Vlc0zx2RYk?=
 =?us-ascii?q?1l1rq1/AMVhPOGR/MN2LILpjshpy91HFmm2tLaEcaPpw1kfK9Ee9My/E9H1X?=
 =?us-ascii?q?7Ftwx6JpGgK6FihlgDcwV4pk/uzAt4BZldkcgwrXMq0ApzJbud0FNGajyYwJ?=
 =?us-ascii?q?TwNaPMJ2ns8xCgdbTW1kvd0NmI4KcP7uo3q1H5sAGuDEoi/G1t08NJ3HuE+p?=
 =?us-ascii?q?XKEA0SXIr1UkY28Rh6ur7bbjA454PRznBsMre0vSXe1NIqHuclzQygf9hHOq?=
 =?us-ascii?q?OeCADyC9EaB9SpKOEyn1ipbxQEPP1d9aItPMOpaeGG2Ki1M+Zkhz+mk2tH75?=
 =?us-ascii?q?5n0k6W9CpzVPTI35AbzPGcxAeHUC38jFi5uMDthY9EfS0SHna4ySX8B45eeL?=
 =?us-ascii?q?dyfYAVBmeqOsG3xs9xh4TwVHFG8l6jBlUG2MCydBqWblz9xhFQ1V8NrXyggS?=
 =?us-ascii?q?u30Tp0kj8zoaqb2CzC2fjtdB0COmRTXmltkU/sIZSoj9AdREWobgcplBy/5U?=
 =?us-ascii?q?rg3KhbuKN/L3HLQUhSZCX2L3xiXbG+t7WcYs5D8o8nsSJSULf0XVfPa7H6uV?=
 =?us-ascii?q?MhzyT7B2IWkDE0cCvsoYn+hwRzoG2YJXd36nHefJc0jQje4NjNbf9X0CAPSC?=
 =?us-ascii?q?RxhX/QHFf4d9qk8M6fkJDAmuu+TWWkV4BWNy7xwsfIrCKm4UVyCAC72vW0nc?=
 =?us-ascii?q?fqVwM91Guz0tltXibPhBXxeI/m0+K9K+0jNkJvHlXx9+J+BYc4lIYs178K3n?=
 =?us-ascii?q?1PvYmY5XoKly/INNxf3a/vJC4WSSUj38/e4A+j3lZqaH2O2dSqBT2m3sJ9ao?=
 =?us-ascii?q?ziMSst0SUn4pUPUf7M4Q=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CFAgBWJt9a/wHyM5BUCBoBAQEBAQIBAQEBCAEBAQGDG?=
 =?us-ascii?q?CtheiiDapR8SwZ6KXUaiyyHV4F4MAYBhEACgnYhNhYBAgEBAQEBAQIBaxwMg?=
 =?us-ascii?q?jUkAYJIAQEBAQIBIwRFCgMQCxgCAiYCAlcGAQwGAgEBgliCJgUID6VUgWkzh?=
 =?us-ascii?q?FiDboI5gQmEW4IogQyBB4EPI4IzBy6DEQGBPA+DFoJUAocxhFqLcAiFXoheB?=
 =?us-ascii?q?oFwimCJOIgeIw0kgVIrCAIYCCEPgn4JghcXiFmFWiMwcQEBj20BAQ?=
Subject: Re: [PATCH 9/9] Protect SELinux initialized state with pmalloc
To: Igor Stoppa <igor.stoppa@gmail.com>, willy@infradead.org,
        keescook@chromium.org, paul@paul-moore.com, mhocko@kernel.org,
        corbet@lwn.net
Cc: labbott@redhat.com, david@fromorbit.com, rppt@linux.vnet.ibm.com,
        linux-security-module@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Igor Stoppa <igor.stoppa@huawei.com>
References: <20180423125458.5338-1-igor.stoppa@huawei.com>
 <20180423125458.5338-10-igor.stoppa@huawei.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <13ee6991-db48-d484-66a6-90de45fad2df@tycho.nsa.gov>
Date: Tue, 24 Apr 2018 08:49:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423125458.5338-10-igor.stoppa@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598541793965902014?=
X-GMAIL-MSGID: =?utf-8?q?1598659092150135696?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/23/2018 08:54 AM, Igor Stoppa wrote:
> SELinux is one of the primary targets, when a system running it comes
> under attack.
> 
> The reason is that, even if an attacker ishould manage to gain root,
> SELinux will still prevent most desirable actions.
> 
> Even in a fully locked down system, SELinux still presents a vulnerability
> that is often exploited, because it is very simple to attack, once
> kernel address layout randomization has been defeated and the attacker
> has gained capability of writing to kernelunprotected data.
> 
> In various places, SELinux relies on an "initialized" internal state
> variable, to decide if the policy is loaded and tests should be
> performed. Needless to say, it's in the interest of hte attacker to turn
> it off and pretend that the policyDB is still uninitialized.
> 
> Even if recent patches move the "initialized" state inside a structure,
> it is still vulnerable.
> 
> This patch seeks to protect it, using it as demo for the pmalloc API,
> which is meant to provide additional protection to data which is likely
> to not be changed very often, if ever (after a transient).
> 
> The patch is probably in need of rework, to make it fit better with the
> new SELinux internal data structures, however it shows how to deny an
> easy target to the attacker.

I know this is just an example, but not sure why you wouldn't just protect the
entire selinux_state.  Note btw that the selinux_state encapsulation is preparatory work
for selinux namespaces [1], at which point the structure is in fact dynamically allocated
and there can be multiple instances of it.  That however is work-in-progress, highly experimental,
and might not ever make it upstream (if we can't resolve the various challenges it poses in a satisfactory
way).

[1] http://blog.namei.org/2018/01/22/lca-2018-kernel-miniconf-selinux-namespacing-slides/


> 
> In case the kernel is compiled with JOP safeguards, then it becomes far
> harder for the attacker to jump into the middle of the function which
> calls pmalloc_rare_write, to alter the state.
> 
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> ---
>  security/selinux/hooks.c            | 12 ++++-----
>  security/selinux/include/security.h |  2 +-
>  security/selinux/ss/services.c      | 51 +++++++++++++++++++++++--------------
>  3 files changed, 39 insertions(+), 26 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 4cafe6a19167..6049f80115bc 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -285,7 +285,7 @@ static int __inode_security_revalidate(struct inode *inode,
>  
>  	might_sleep_if(may_sleep);
>  
> -	if (selinux_state.initialized &&
> +	if (*ss_initialized_ptr &&
>  	    isec->initialized != LABEL_INITIALIZED) {
>  		if (!may_sleep)
>  			return -ECHILD;
> @@ -612,7 +612,7 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
>  	if (!(sbsec->flags & SE_SBINITIALIZED))
>  		return -EINVAL;
>  
> -	if (!selinux_state.initialized)
> +	if (!*ss_initialized_ptr)
>  		return -EINVAL;
>  
>  	/* make sure we always check enough bits to cover the mask */
> @@ -735,7 +735,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>  
>  	mutex_lock(&sbsec->lock);
>  
> -	if (!selinux_state.initialized) {
> +	if (!*ss_initialized_ptr) {
>  		if (!num_opts) {
>  			/* Defer initialization until selinux_complete_init,
>  			   after the initial policy is loaded and the security
> @@ -1022,7 +1022,7 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
>  	 * if the parent was able to be mounted it clearly had no special lsm
>  	 * mount options.  thus we can safely deal with this superblock later
>  	 */
> -	if (!selinux_state.initialized)
> +	if (!*ss_initialized_ptr)
>  		return 0;
>  
>  	/*
> @@ -3040,7 +3040,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>  		isec->initialized = LABEL_INITIALIZED;
>  	}
>  
> -	if (!selinux_state.initialized || !(sbsec->flags & SBLABEL_MNT))
> +	if (!*ss_initialized_ptr || !(sbsec->flags & SBLABEL_MNT))
>  		return -EOPNOTSUPP;
>  
>  	if (name)
> @@ -7253,7 +7253,7 @@ static void selinux_nf_ip_exit(void)
>  #ifdef CONFIG_SECURITY_SELINUX_DISABLE
>  int selinux_disable(struct selinux_state *state)
>  {
> -	if (state->initialized) {
> +	if (*ss_initialized_ptr) {
>  		/* Not permitted after initial policy load. */
>  		return -EINVAL;
>  	}
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 23e762d529fa..ec7debb143be 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -96,13 +96,13 @@ extern char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX];
>  struct selinux_avc;
>  struct selinux_ss;
>  
> +extern bool *ss_initialized_ptr;
>  struct selinux_state {
>  	bool disabled;
>  #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
>  	bool enforcing;
>  #endif
>  	bool checkreqprot;
> -	bool initialized;
>  	bool policycap[__POLICYDB_CAPABILITY_MAX];
>  	struct selinux_avc *avc;
>  	struct selinux_ss *ss;
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 8057e19dc15f..c09ca6f9b269 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -52,6 +52,7 @@
>  #include <linux/selinux.h>
>  #include <linux/flex_array.h>
>  #include <linux/vmalloc.h>
> +#include <linux/pmalloc.h>
>  #include <net/netlabel.h>
>  
>  #include "flask.h"
> @@ -80,10 +81,20 @@ char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
>  	"nnp_nosuid_transition"
>  };
>  
> +bool *ss_initialized_ptr __ro_after_init;
> +static struct pmalloc_pool *selinux_pool;
>  static struct selinux_ss selinux_ss;
>  
>  void selinux_ss_init(struct selinux_ss **ss)
>  {
> +	selinux_pool = pmalloc_create_pool(PMALLOC_RW);
> +	if (unlikely(!selinux_pool))
> +		panic("SELinux: unable to create pmalloc pool.");
> +	ss_initialized_ptr = pmalloc(selinux_pool, sizeof(bool));
> +	if (unlikely(!ss_initialized_ptr))
> +		panic("SElinux: unable to allocate from pmalloc pool.");
> +	*ss_initialized_ptr = false;
> +	pmalloc_protect_pool(selinux_pool);
>  	rwlock_init(&selinux_ss.policy_rwlock);
>  	mutex_init(&selinux_ss.status_lock);
>  	*ss = &selinux_ss;
> @@ -772,7 +783,7 @@ static int security_compute_validatetrans(struct selinux_state *state,
>  	int rc = 0;
>  
>  
> -	if (!state->initialized)
> +	if (!*ss_initialized_ptr)
>  		return 0;
>  
>  	read_lock(&state->ss->policy_rwlock);
> @@ -872,7 +883,7 @@ int security_bounded_transition(struct selinux_state *state,
>  	int index;
>  	int rc;
>  
> -	if (!state->initialized)
> +	if (!*ss_initialized_ptr)
>  		return 0;
>  
>  	read_lock(&state->ss->policy_rwlock);
> @@ -1032,7 +1043,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
>  	memset(xpermd->dontaudit->p, 0, sizeof(xpermd->dontaudit->p));
>  
>  	read_lock(&state->ss->policy_rwlock);
> -	if (!state->initialized)
> +	if (!*ss_initialized_ptr)
>  		goto allow;
>  
>  	policydb = &state->ss->policydb;
> @@ -1121,7 +1132,7 @@ void security_compute_av(struct selinux_state *state,
>  	read_lock(&state->ss->policy_rwlock);
>  	avd_init(state, avd);
>  	xperms->len = 0;
> -	if (!state->initialized)
> +	if (!*ss_initialized_ptr)
>  		goto allow;
>  
>  	policydb = &state->ss->policydb;
> @@ -1175,7 +1186,7 @@ void security_compute_av_user(struct selinux_state *state,
>  
>  	read_lock(&state->ss->policy_rwlock);
>  	avd_init(state, avd);
> -	if (!state->initialized)
> +	if (!*ss_initialized_ptr)
>  		goto allow;
>  
>  	policydb = &state->ss->policydb;
> @@ -1294,7 +1305,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
>  		*scontext = NULL;
>  	*scontext_len  = 0;
>  
> -	if (!state->initialized) {
> +	if (!*ss_initialized_ptr) {
>  		if (sid <= SECINITSID_NUM) {
>  			char *scontextp;
>  
> @@ -1466,7 +1477,7 @@ static int security_context_to_sid_core(struct selinux_state *state,
>  	if (!scontext2)
>  		return -ENOMEM;
>  
> -	if (!state->initialized) {
> +	if (!*ss_initialized_ptr) {
>  		int i;
>  
>  		for (i = 1; i < SECINITSID_NUM; i++) {
> @@ -1648,7 +1659,7 @@ static int security_compute_sid(struct selinux_state *state,
>  	int rc = 0;
>  	bool sock;
>  
> -	if (!state->initialized) {
> +	if (!*ss_initialized_ptr) {
>  		switch (orig_tclass) {
>  		case SECCLASS_PROCESS: /* kernel value */
>  			*out_sid = ssid;
> @@ -2128,7 +2139,8 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>  	policydb = &state->ss->policydb;
>  	sidtab = &state->ss->sidtab;
>  
> -	if (!state->initialized) {
> +	if (!*ss_initialized_ptr) {
> +		bool dummy_initialized = true;
>  		rc = policydb_read(policydb, fp);
>  		if (rc)
>  			goto out;
> @@ -2148,7 +2160,8 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>  		}
>  
>  		security_load_policycaps(state);
> -		state->initialized = 1;
> +		pmalloc_rare_write(selinux_pool, ss_initialized_ptr,
> +				   &dummy_initialized, sizeof(bool));
>  		seqno = ++state->ss->latest_granting;
>  		selinux_complete_init();
>  		avc_ss_reset(state->avc, seqno);
> @@ -2578,7 +2591,7 @@ int security_get_user_sids(struct selinux_state *state,
>  	*sids = NULL;
>  	*nel = 0;
>  
> -	if (!state->initialized)
> +	if (!*ss_initialized_ptr)
>  		goto out;
>  
>  	read_lock(&state->ss->policy_rwlock);
> @@ -2812,7 +2825,7 @@ int security_get_bools(struct selinux_state *state,
>  	struct policydb *policydb;
>  	int i, rc;
>  
> -	if (!state->initialized) {
> +	if (!*ss_initialized_ptr) {
>  		*len = 0;
>  		*names = NULL;
>  		*values = NULL;
> @@ -2987,7 +3000,7 @@ int security_sid_mls_copy(struct selinux_state *state,
>  	int rc;
>  
>  	rc = 0;
> -	if (!state->initialized || !policydb->mls_enabled) {
> +	if (!*ss_initialized_ptr || !policydb->mls_enabled) {
>  		*new_sid = sid;
>  		goto out;
>  	}
> @@ -3094,7 +3107,7 @@ int security_net_peersid_resolve(struct selinux_state *state,
>  	/*
>  	 * We don't need to check initialized here since the only way both
>  	 * nlbl_sid and xfrm_sid are not equal to SECSID_NULL would be if the
> -	 * security server was initialized and state->initialized was true.
> +	 * security server was initialized and *ss_initialized_ptr was true.
>  	 */
>  	if (!policydb->mls_enabled)
>  		return 0;
> @@ -3149,7 +3162,7 @@ int security_get_classes(struct selinux_state *state,
>  	struct policydb *policydb = &state->ss->policydb;
>  	int rc;
>  
> -	if (!state->initialized) {
> +	if (!*ss_initialized_ptr) {
>  		*nclasses = 0;
>  		*classes = NULL;
>  		return 0;
> @@ -3298,7 +3311,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
>  
>  	*rule = NULL;
>  
> -	if (!state->initialized)
> +	if (!*ss_initialized_ptr)
>  		return -EOPNOTSUPP;
>  
>  	switch (field) {
> @@ -3598,7 +3611,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
>  	struct context *ctx;
>  	struct context ctx_new;
>  
> -	if (!state->initialized) {
> +	if (!*ss_initialized_ptr) {
>  		*sid = SECSID_NULL;
>  		return 0;
>  	}
> @@ -3665,7 +3678,7 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
>  	int rc;
>  	struct context *ctx;
>  
> -	if (!state->initialized)
> +	if (!*ss_initialized_ptr)
>  		return 0;
>  
>  	read_lock(&state->ss->policy_rwlock);
> @@ -3704,7 +3717,7 @@ int security_read_policy(struct selinux_state *state,
>  	int rc;
>  	struct policy_file fp;
>  
> -	if (!state->initialized)
> +	if (!*ss_initialized_ptr)
>  		return -EINVAL;
>  
>  	*len = security_policydb_len(state);
> 
