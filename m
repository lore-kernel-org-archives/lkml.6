Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeA3Np4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:45:56 -0500
Received: from uhil19pa10.eemsg.mail.mil ([214.24.21.83]:10566 "EHLO
        uhil19pa10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbeA3Npx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:45:53 -0500
X-IronPort-AV: E=Sophos;i="5.46,435,1511827200";
   d="scan'208";a="8706531"
IronPort-PHdr: =?us-ascii?q?9a23=3ApH8dIhfOcL58RhBggpylTBg3lGMj4u6mDksu8pMi?=
 =?us-ascii?q?zoh2WeGdxc2yZhSN2/xhgRfzUJnB7Loc0qyK6/mmATRIyK3CmUhKSIZLWR4BhJ?=
 =?us-ascii?q?detC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBxrwKxd+?=
 =?us-ascii?q?KPjrFY7OlcS30P2594HObwlSizexfa5+IA+qoQnNq8IbnZZsJqEtxxXTv3BGYf?=
 =?us-ascii?q?5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ7NYCi8mM30u683wqRbD?=
 =?us-ascii?q?VwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xymp4rx1QxH0li?=
 =?us-ascii?q?gIKz858HnWisNuiqJbvAmhrAF7z4LNfY2ZKOZycqbbcNwUX2pBWttaWTJHDI2y?=
 =?us-ascii?q?coADC/MNMftEo4X4oVYFsBmwChS2BO73yTFGm3/407M03esjHwHJwAsuEN0Bvn?=
 =?us-ascii?q?nPsNX4Nr0fXfyvwaXUzzjOae5d1zfn6IjPdxAsueyCXa5ufsrJyUkgCQXFhUiN?=
 =?us-ascii?q?p4zgJTyV0uANvHab7uF9Uu+vkHMoqxpqrzizxsYjlonJhoUPxlDC7iV22pw5Jd?=
 =?us-ascii?q?K/SE5leNOpFoZbuS+dN4tzWMwiQmdotT41yr0HpZ67fDUKx489yxHDbPyHdo6F?=
 =?us-ascii?q?6Q/gWuaJOTp0mX1odb2lixuy7ESs0PPwW8aq3FpQsyZIlMTHuGoX2BzJ8MeHT+?=
 =?us-ascii?q?Nw/kKm2TmSyQ/e8vpEIUUolarDLJ4h36IwmoITsUvdGi/2n137jLOMeUU+++io?=
 =?us-ascii?q?9v/nbq/6pp6cK4B0igb+Pr4omsOjGuQ3LhICX22a+eS4zLHj/Ev5T6tWjvAuj6?=
 =?us-ascii?q?XUv5/XKd4bq6KkGQNZzIku5wilAzu7yNgYmGMILFNBeBKJlYjpPFTOLejjDfii?=
 =?us-ascii?q?mFShiytrxvDaMb3hBZXBNH7DkKz7crpn5E5czxQzwchF551IErEBPO7zWkjpud?=
 =?us-ascii?q?zDEBA5KQO0zPj8BdV9zIweXWaPA6+fMK/IrVCI4ecvKfGWZIAJoDb9N+Ql5/n2?=
 =?us-ascii?q?gHAjnV8dZrOm0YIKZ3+mAPRpPUGZbGH2jdcFCmcFpBMyTPTwiF2FUz5ceWq9X7?=
 =?us-ascii?q?4m6jE8EoKmAp/JRpqxj7yZwCe7AppWa3hDClCNF3foeIKEVuwWaC2MP8BhkiYL?=
 =?us-ascii?q?VaS7R4A90hGusRfwy6B7IerM5i0YqZXj2cBx5+3SkxEy6DN1A92e026TVWF0mH?=
 =?us-ascii?q?0HRzst0aBhrkxy1E2D3bJ7g/NGD9xT4e1GUgMgOZ7b1ex6BMj4WhjdcdeRVFam?=
 =?us-ascii?q?XtKmDCk1TtIwxd8Ofkl8F8y5jh/dwyWqHqUVl72XBJ00667c2n/xKNtgy3bCyq?=
 =?us-ascii?q?YslEcmQsRROm28nKJ/9BbcB5TPk0qHk6amb6Mc3DTC9G2b12qBoFlYUBJsUaXC?=
 =?us-ascii?q?RX0Qe0/Wosrk6UPMSL+uE6koPxBbycGcN6RKasfmjUlcSPj/P9TeZnq7m32sCh?=
 =?us-ascii?q?aQ2rOMcI3qdn0A0yrHDkgEkh4c/XKENQUlAyeuvWbeDDh0GlLpZEPt/vNyp2+8?=
 =?us-ascii?q?Tk8x1wuKdVFu16Kp+h4JgvyRU/ET0agBuCg/sDV4BlK908jTC9qHvQphZqRcYc?=
 =?us-ascii?q?gm7VdAz2LWrRByPpi+IKx4mlEedAF3tVv01xprEoVAjdQqrHQywQVsMaKXyklB?=
 =?us-ascii?q?dzKD3Z3rIr3YMHPy/BG0a67O3lHRysqZ9bkV5PQ/sVXjsxmjFlA+/HV/z9lVz3?=
 =?us-ascii?q?yc643SDAUITJLxVl069wBgqLHHZikx/obU1XprMamurDDOwc4mBOwgyhy4ZddQ?=
 =?us-ascii?q?LLuEFBPuE80dH8WuMPIlm0S3YRIeJuxd6qg0MN64ePucw6GrO/xgnD29gGRc54?=
 =?us-ascii?q?B91EKN+zBgRe7P2pZWi82fixOKSzrmylqnvs3tk4deahkJGWyujyPjAcoZXqRv?=
 =?us-ascii?q?ec4uDmC0LoXj3txjg7b1UmNcsVukAEkLnsSufEzWJ3Hn3AYY7U0NoGfvzSagxi?=
 =?us-ascii?q?Z1iBkxp7CexzTKyu/vMh0dNTgPDEtriFr3aa2zlcobRwD8bQEsmQDj4QD/wLJB?=
 =?us-ascii?q?pb9XKHPaSkNFOSPxKjcmGoe5sLuPZ4Zt9YknvCNMGLCwaFabR7r/ix4X1yfqGW?=
 =?us-ascii?q?xOgjs8cmfu8rn+ghMyrG+RInFpoDKNdcV9yRnY/tD0X/Nd3jMaAiJ/jG+TTkOx?=
 =?us-ascii?q?O9iv4MW8i4bIsuf4UXmoEJJUb22jyYKGqTv+/mBhHAe+g+H2n9rrDAw3+TH02s?=
 =?us-ascii?q?MsVijSqhv4JI7x2ODyNeNhY1ktB1Lm7cd+Mp9xn5F2h5wK33UewJKP8j5PsGH8?=
 =?us-ascii?q?Np1+3qb4ZWBFETsKxdHSyBLo1E1qMjSCwIevEj2UxtBoItW3fG4S8is59MkPEL?=
 =?us-ascii?q?2T7rFPgW1yuFX85UjqbOJyk38wgb1myHceh/AP8kJ51SiHDb06HUBcOT3q0R+P?=
 =?us-ascii?q?6obtgr9QYTOUbbWo1Ed41eukBbWGrxAUDG31Yb8+DCRw6YN5K1uK33rtvNK3MO?=
 =?us-ascii?q?LMZM4e40XH2yzLiPJYfddoz6IH?=
X-IPAS-Result: =?us-ascii?q?A2D0AQDydXBa/wHyM5BbGQEBAQEBAQEBAQEBAQcBAQEBAYM?=
 =?us-ascii?q?VLWZ1KINgmRFCAQEBAQEBBoE0fJZJghcvhRYCgkRWFgEBAQEBAQEBAgFqKEIOA?=
 =?us-ascii?q?YFnJAGCRgEBAQECARoJBGILFQMCAiYCAlcGARKIDIIcBQgQpTuBbTqEFgEBhk4?=
 =?us-ascii?q?BAQEHAQEBAQEBARwFgQ+DRYIVgQ+CMIJ4NoMvAgKBb4MXgmUFimSIcJBDiBiNU?=
 =?us-ascii?q?IIbkg6LBYJhiz0lATKBUCsIAhgIIQ+CZ4JSAxyBSwE5HyM3CoURh0IrgiABAQE?=
Message-ID: <1517320017.14420.7.camel@tycho.nsa.gov>
Subject: Re: [PATCH v2 1/5] selinux:Remove direct references to policydb.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: peter.enderborg@sony.com, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <james.l.morris@oracle.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, alsa-devel@alsa-project.org,
        "Serge E . Hallyn" <serge@hallyn.com>
Date: Tue, 30 Jan 2018 08:46:57 -0500
In-Reply-To: <20180126143241.23108-2-peter.enderborg@sony.com>
References: <20180126143241.23108-1-peter.enderborg@sony.com>
         <20180126143241.23108-2-peter.enderborg@sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-01-26 at 15:32 +0100, peter.enderborg@sony.com wrote:
> From: Peter Enderborg <peter.enderborg@sony.com>
> 
> To be able to use rcu locks we seed to address the policydb
> though a pointer. This preparation removes the export of the
> policydb and send pointers to it through parameter agruments.

Just for reference, I have a patch series that does this not only for
the policydb, sidtab, and class/perm mapping, but for all of the
SELinux global state, see:
https://github.com/stephensmalley/selinux-kernel/tree/selinuxns
and in particular
https://github.com/stephensmalley/selinux-kernel/commit/c10d90b43cd720c8f8aab51007e805bf7c4f10d2
https://github.com/stephensmalley/selinux-kernel/commit/ec038a64173d56a331423b6d1564b801f0915afc
https://github.com/stephensmalley/selinux-kernel/commit/97aa5d7a05e4458bc4562c47d8f7bc4f56fbfefd

Those first three patches should have no effect on SELinux behavior.
They need to be re-based to latest selinux next branch (some minor
conflict resolution required) but I was waiting for that to advance to
something 4.15-rcX based.  I could however re-base it now if desired.

> 
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>  security/selinux/ss/mls.c      | 69 ++++++++++++++++----------------
>  security/selinux/ss/mls.h      | 37 +++++++++--------
>  security/selinux/ss/services.c | 90 +++++++++++++++++++++++++++-----
> ----------
>  security/selinux/ss/services.h |  3 --
>  4 files changed, 114 insertions(+), 85 deletions(-)
> 
> diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> index ad982ce..b1f35d3 100644
> --- a/security/selinux/ss/mls.c
> +++ b/security/selinux/ss/mls.c
> @@ -33,20 +33,20 @@
>   * Return the length in bytes for the MLS fields of the
>   * security context string representation of `context'.
>   */
> -int mls_compute_context_len(struct context *context)
> +int mls_compute_context_len(struct policydb *p, struct context
> *context)
>  {
>  	int i, l, len, head, prev;
>  	char *nm;
>  	struct ebitmap *e;
>  	struct ebitmap_node *node;
>  
> -	if (!policydb.mls_enabled)
> +	if (!p->mls_enabled)
>  		return 0;
>  
>  	len = 1; /* for the beginning ":" */
>  	for (l = 0; l < 2; l++) {
>  		int index_sens = context->range.level[l].sens;
> -		len += strlen(sym_name(&policydb, SYM_LEVELS,
> index_sens - 1));
> +		len += strlen(sym_name(p, SYM_LEVELS, index_sens -
> 1));
>  
>  		/* categories */
>  		head = -2;
> @@ -56,17 +56,17 @@ int mls_compute_context_len(struct context
> *context)
>  			if (i - prev > 1) {
>  				/* one or more negative bits are
> skipped */
>  				if (head != prev) {
> -					nm = sym_name(&policydb,
> SYM_CATS, prev);
> +					nm = sym_name(p, SYM_CATS,
> prev);
>  					len += strlen(nm) + 1;
>  				}
> -				nm = sym_name(&policydb, SYM_CATS,
> i);
> +				nm = sym_name(p, SYM_CATS, i);
>  				len += strlen(nm) + 1;
>  				head = i;
>  			}
>  			prev = i;
>  		}
>  		if (prev != head) {
> -			nm = sym_name(&policydb, SYM_CATS, prev);
> +			nm = sym_name(p, SYM_CATS, prev);
>  			len += strlen(nm) + 1;
>  		}
>  		if (l == 0) {
> @@ -86,7 +86,7 @@ int mls_compute_context_len(struct context
> *context)
>   * the MLS fields of `context' into the string `*scontext'.
>   * Update `*scontext' to point to the end of the MLS fields.
>   */
> -void mls_sid_to_context(struct context *context,
> +void mls_sid_to_context(struct policydb *p, struct context *context,
>  			char **scontext)
>  {
>  	char *scontextp, *nm;
> @@ -94,7 +94,7 @@ void mls_sid_to_context(struct context *context,
>  	struct ebitmap *e;
>  	struct ebitmap_node *node;
>  
> -	if (!policydb.mls_enabled)
> +	if (!p->mls_enabled)
>  		return;
>  
>  	scontextp = *scontext;
> @@ -103,7 +103,7 @@ void mls_sid_to_context(struct context *context,
>  	scontextp++;
>  
>  	for (l = 0; l < 2; l++) {
> -		strcpy(scontextp, sym_name(&policydb, SYM_LEVELS,
> +		strcpy(scontextp, sym_name(p, SYM_LEVELS,
>  					   context-
> >range.level[l].sens - 1));
>  		scontextp += strlen(scontextp);
>  
> @@ -119,7 +119,7 @@ void mls_sid_to_context(struct context *context,
>  						*scontextp++ = '.';
>  					else
>  						*scontextp++ = ',';
> -					nm = sym_name(&policydb,
> SYM_CATS, prev);
> +					nm = sym_name(p, SYM_CATS,
> prev);
>  					strcpy(scontextp, nm);
>  					scontextp += strlen(nm);
>  				}
> @@ -127,7 +127,7 @@ void mls_sid_to_context(struct context *context,
>  					*scontextp++ = ':';
>  				else
>  					*scontextp++ = ',';
> -				nm = sym_name(&policydb, SYM_CATS,
> i);
> +				nm = sym_name(p, SYM_CATS, i);
>  				strcpy(scontextp, nm);
>  				scontextp += strlen(nm);
>  				head = i;
> @@ -140,7 +140,7 @@ void mls_sid_to_context(struct context *context,
>  				*scontextp++ = '.';
>  			else
>  				*scontextp++ = ',';
> -			nm = sym_name(&policydb, SYM_CATS, prev);
> +			nm = sym_name(p, SYM_CATS, prev);
>  			strcpy(scontextp, nm);
>  			scontextp += strlen(nm);
>  		}
> @@ -375,12 +375,13 @@ int mls_context_to_sid(struct policydb *pol,
>   * the string `str'.  This function will allocate temporary memory
> with the
>   * given constraints of gfp_mask.
>   */
> -int mls_from_string(char *str, struct context *context, gfp_t
> gfp_mask)
> +int mls_from_string(struct policydb *p, char *str, struct context
> *context,
> +		    gfp_t gfp_mask)
>  {
>  	char *tmpstr, *freestr;
>  	int rc;
>  
> -	if (!policydb.mls_enabled)
> +	if (!p->mls_enabled)
>  		return -EINVAL;
>  
>  	/* we need freestr because mls_context_to_sid will change
> @@ -389,7 +390,7 @@ int mls_from_string(char *str, struct context
> *context, gfp_t gfp_mask)
>  	if (!tmpstr) {
>  		rc = -ENOMEM;
>  	} else {
> -		rc = mls_context_to_sid(&policydb, ':', &tmpstr,
> context,
> +		rc = mls_context_to_sid(p, ':', &tmpstr, context,
>  					NULL, SECSID_NULL);
>  		kfree(freestr);
>  	}
> @@ -417,10 +418,10 @@ int mls_range_set(struct context *context,
>  	return rc;
>  }
>  
> -int mls_setup_user_range(struct context *fromcon, struct user_datum
> *user,
> -			 struct context *usercon)
> +int mls_setup_user_range(struct policydb *p, struct context
> *fromcon,
> +			 struct user_datum *user, struct context
> *usercon)
>  {
> -	if (policydb.mls_enabled) {
> +	if (p->mls_enabled) {
>  		struct mls_level *fromcon_sen = &(fromcon-
> >range.level[0]);
>  		struct mls_level *fromcon_clr = &(fromcon-
> >range.level[1]);
>  		struct mls_level *user_low = &(user-
> >range.level[0]);
> @@ -460,7 +461,7 @@ int mls_setup_user_range(struct context *fromcon,
> struct user_datum *user,
>   * structure `c' from the values specified in the
>   * policy `oldp' to the values specified in the policy `newp'.
>   */
> -int mls_convert_context(struct policydb *oldp,
> +int mls_convert_context(struct policydb *p, struct policydb *oldp,
>  			struct policydb *newp,
>  			struct context *c)
>  {
> @@ -470,7 +471,7 @@ int mls_convert_context(struct policydb *oldp,
>  	struct ebitmap_node *node;
>  	int l, i;
>  
> -	if (!policydb.mls_enabled)
> +	if (!p->mls_enabled)
>  		return 0;
>  
>  	for (l = 0; l < 2; l++) {
> @@ -503,7 +504,7 @@ int mls_convert_context(struct policydb *oldp,
>  	return 0;
>  }
>  
> -int mls_compute_sid(struct context *scontext,
> +int mls_compute_sid(struct policydb *p, struct context *scontext,
>  		    struct context *tcontext,
>  		    u16 tclass,
>  		    u32 specified,
> @@ -515,7 +516,7 @@ int mls_compute_sid(struct context *scontext,
>  	struct class_datum *cladatum;
>  	int default_range = 0;
>  
> -	if (!policydb.mls_enabled)
> +	if (!p->mls_enabled)
>  		return 0;
>  
>  	switch (specified) {
> @@ -524,12 +525,12 @@ int mls_compute_sid(struct context *scontext,
>  		rtr.source_type = scontext->type;
>  		rtr.target_type = tcontext->type;
>  		rtr.target_class = tclass;
> -		r = hashtab_search(policydb.range_tr, &rtr);
> +		r = hashtab_search(p->range_tr, &rtr);
>  		if (r)
>  			return mls_range_set(newcontext, r);
>  
> -		if (tclass && tclass <= policydb.p_classes.nprim) {
> -			cladatum =
> policydb.class_val_to_struct[tclass - 1];
> +		if (tclass && tclass <= p->p_classes.nprim) {
> +			cladatum = p->class_val_to_struct[tclass -
> 1];
>  			if (cladatum)
>  				default_range = cladatum-
> >default_range;
>  		}
> @@ -551,7 +552,7 @@ int mls_compute_sid(struct context *scontext,
>  
>  		/* Fallthrough */
>  	case AVTAB_CHANGE:
> -		if ((tclass == policydb.process_class) || (sock ==
> true))
> +		if ((tclass == p->process_class) || (sock == true))
>  			/* Use the process MLS attributes. */
>  			return mls_context_cpy(newcontext,
> scontext);
>  		else
> @@ -577,10 +578,10 @@ int mls_compute_sid(struct context *scontext,
>   * NetLabel MLS sensitivity level field.
>   *
>   */
> -void mls_export_netlbl_lvl(struct context *context,
> +void mls_export_netlbl_lvl(struct policydb *p, struct context
> *context,
>  			   struct netlbl_lsm_secattr *secattr)
>  {
> -	if (!policydb.mls_enabled)
> +	if (!p->mls_enabled)
>  		return;
>  
>  	secattr->attr.mls.lvl = context->range.level[0].sens - 1;
> @@ -597,10 +598,10 @@ void mls_export_netlbl_lvl(struct context
> *context,
>   * NetLabel MLS sensitivity level into the context.
>   *
>   */
> -void mls_import_netlbl_lvl(struct context *context,
> +void mls_import_netlbl_lvl(struct policydb *p, struct context
> *context,
>  			   struct netlbl_lsm_secattr *secattr)
>  {
> -	if (!policydb.mls_enabled)
> +	if (!p->mls_enabled)
>  		return;
>  
>  	context->range.level[0].sens = secattr->attr.mls.lvl + 1;
> @@ -617,12 +618,12 @@ void mls_import_netlbl_lvl(struct context
> *context,
>   * MLS category field.  Returns zero on success, negative values on
> failure.
>   *
>   */
> -int mls_export_netlbl_cat(struct context *context,
> +int mls_export_netlbl_cat(struct policydb *p, struct context
> *context,
>  			  struct netlbl_lsm_secattr *secattr)
>  {
>  	int rc;
>  
> -	if (!policydb.mls_enabled)
> +	if (!p->mls_enabled)
>  		return 0;
>  
>  	rc = ebitmap_netlbl_export(&context->range.level[0].cat,
> @@ -645,12 +646,12 @@ int mls_export_netlbl_cat(struct context
> *context,
>   * negative values on failure.
>   *
>   */
> -int mls_import_netlbl_cat(struct context *context,
> +int mls_import_netlbl_cat(struct policydb *p, struct context
> *context,
>  			  struct netlbl_lsm_secattr *secattr)
>  {
>  	int rc;
>  
> -	if (!policydb.mls_enabled)
> +	if (!p->mls_enabled)
>  		return 0;
>  
>  	rc = ebitmap_netlbl_import(&context->range.level[0].cat,
> diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
> index 131d762..cb039c0 100644
> --- a/security/selinux/ss/mls.h
> +++ b/security/selinux/ss/mls.h
> @@ -25,8 +25,9 @@
>  #include "context.h"
>  #include "policydb.h"
>  
> -int mls_compute_context_len(struct context *context);
> -void mls_sid_to_context(struct context *context, char **scontext);
> +int mls_compute_context_len(struct policydb *p, struct context
> *context);
> +void mls_sid_to_context(struct policydb *p, struct context *context,
> +			char **scontext);
>  int mls_context_isvalid(struct policydb *p, struct context *c);
>  int mls_range_isvalid(struct policydb *p, struct mls_range *r);
>  int mls_level_isvalid(struct policydb *p, struct mls_level *l);
> @@ -38,50 +39,55 @@ int mls_context_to_sid(struct policydb *p,
>  		       struct sidtab *s,
>  		       u32 def_sid);
>  
> -int mls_from_string(char *str, struct context *context, gfp_t
> gfp_mask);
> +int mls_from_string(struct policydb *p, char *str, struct context
> *context,
> +		    gfp_t gfp_mask);
>  
>  int mls_range_set(struct context *context, struct mls_range *range);
>  
> -int mls_convert_context(struct policydb *oldp,
> +int mls_convert_context(struct policydb *p, struct policydb *oldp,
>  			struct policydb *newp,
>  			struct context *context);
>  
> -int mls_compute_sid(struct context *scontext,
> +int mls_compute_sid(struct policydb *p, struct context *scontext,
>  		    struct context *tcontext,
>  		    u16 tclass,
>  		    u32 specified,
>  		    struct context *newcontext,
>  		    bool sock);
>  
> -int mls_setup_user_range(struct context *fromcon, struct user_datum
> *user,
> -			 struct context *usercon);
> +int mls_setup_user_range(struct policydb *p, struct context
> *fromcon,
> +			 struct user_datum *user, struct context
> *usercon);
>  
>  #ifdef CONFIG_NETLABEL
> -void mls_export_netlbl_lvl(struct context *context,
> +void mls_export_netlbl_lvl(struct policydb *p, struct context
> *context,
>  			   struct netlbl_lsm_secattr *secattr);
> -void mls_import_netlbl_lvl(struct context *context,
> +void mls_import_netlbl_lvl(struct policydb *p, struct context
> *context,
>  			   struct netlbl_lsm_secattr *secattr);
> -int mls_export_netlbl_cat(struct context *context,
> +int mls_export_netlbl_cat(struct policydb *p, struct context
> *context,
>  			  struct netlbl_lsm_secattr *secattr);
> -int mls_import_netlbl_cat(struct context *context,
> +int mls_import_netlbl_cat(struct policydb *p, struct context
> *context,
>  			  struct netlbl_lsm_secattr *secattr);
>  #else
> -static inline void mls_export_netlbl_lvl(struct context *context,
> +static inline void mls_export_netlbl_lvl(struct policydb *p,
> +					 struct context *context,
>  					 struct netlbl_lsm_secattr
> *secattr)
>  {
>  	return;
>  }
> -static inline void mls_import_netlbl_lvl(struct context *context,
> +static inline void mls_import_netlbl_lvl(struct policydb *p,
> +					 struct context *context,
>  					 struct netlbl_lsm_secattr
> *secattr)
>  {
>  	return;
>  }
> -static inline int mls_export_netlbl_cat(struct context *context,
> +static inline int mls_export_netlbl_cat(struct policydb *p,
> +					struct context *context,
>  					struct netlbl_lsm_secattr
> *secattr)
>  {
>  	return -ENOMEM;
>  }
> -static inline int mls_import_netlbl_cat(struct context *context,
> +static inline int mls_import_netlbl_cat(struct policydb *p,
> +					struct context *context,
>  					struct netlbl_lsm_secattr
> *secattr)
>  {
>  	return -ENOMEM;
> @@ -89,4 +95,3 @@ static inline int mls_import_netlbl_cat(struct
> context *context,
>  #endif
>  
>  #endif	/* _SS_MLS_H */
> -
> diff --git a/security/selinux/ss/services.c
> b/security/selinux/ss/services.c
> index 33cfe5d..47d8030 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -90,7 +90,7 @@ int selinux_policycap_nnp_nosuid_transition;
>  static DEFINE_RWLOCK(policy_rwlock);
>  
>  static struct sidtab sidtab;
> -struct policydb policydb;
> +static struct policydb policydb;
>  int ss_initialized;
>  
>  /*
> @@ -117,8 +117,12 @@ struct selinux_mapping {
>  	u32 perms[sizeof(u32) * 8];
>  };
>  
> -static struct selinux_mapping *current_mapping;
> -static u16 current_mapping_size;
> +struct shared_current_mapping {
> +	struct selinux_mapping *current_mapping;
> +	u16 current_mapping_size;
> +};
> +
> +static struct shared_current_mapping *crm;
>  
>  static int selinux_set_mapping(struct policydb *pol,
>  			       struct security_class_mapping *map,
> @@ -208,8 +212,8 @@ static int selinux_set_mapping(struct policydb
> *pol,
>  
>  static u16 unmap_class(u16 tclass)
>  {
> -	if (tclass < current_mapping_size)
> -		return current_mapping[tclass].value;
> +	if (tclass < crm->current_mapping_size)
> +		return crm->current_mapping[tclass].value;
>  
>  	return tclass;
>  }
> @@ -221,8 +225,8 @@ static u16 map_class(u16 pol_value)
>  {
>  	u16 i;
>  
> -	for (i = 1; i < current_mapping_size; i++) {
> -		if (current_mapping[i].value == pol_value)
> +	for (i = 1; i < crm->current_mapping_size; i++) {
> +		if (crm->current_mapping[i].value == pol_value)
>  			return i;
>  	}
>  
> @@ -232,27 +236,32 @@ static u16 map_class(u16 pol_value)
>  static void map_decision(u16 tclass, struct av_decision *avd,
>  			 int allow_unknown)
>  {
> -	if (tclass < current_mapping_size) {
> -		unsigned i, n = current_mapping[tclass].num_perms;
> +	if (tclass < crm->current_mapping_size) {
> +		unsigned int i, n = crm-
> >current_mapping[tclass].num_perms;
>  		u32 result;
>  
>  		for (i = 0, result = 0; i < n; i++) {
> -			if (avd->allowed &
> current_mapping[tclass].perms[i])
> +			if (avd->allowed &
> +			    crm->current_mapping[tclass].perms[i])
>  				result |= 1<<i;
> -			if (allow_unknown &&
> !current_mapping[tclass].perms[i])
> +			if (allow_unknown &&
> +			    !crm->current_mapping[tclass].perms[i])
>  				result |= 1<<i;
>  		}
>  		avd->allowed = result;
>  
>  		for (i = 0, result = 0; i < n; i++)
> -			if (avd->auditallow &
> current_mapping[tclass].perms[i])
> +			if (avd->auditallow &
> +			    crm->current_mapping[tclass].perms[i])
>  				result |= 1<<i;
>  		avd->auditallow = result;
>  
>  		for (i = 0, result = 0; i < n; i++) {
> -			if (avd->auditdeny &
> current_mapping[tclass].perms[i])
> +			if (avd->auditdeny &
> +			    crm->current_mapping[tclass].perms[i])
>  				result |= 1<<i;
> -			if (!allow_unknown &&
> !current_mapping[tclass].perms[i])
> +			if (!allow_unknown &&
> +			    !crm->current_mapping[tclass].perms[i])
>  				result |= 1<<i;
>  		}
>  		/*
> @@ -1211,7 +1220,7 @@ static int context_struct_to_string(struct
> context *context, char **scontext, u3
>  	*scontext_len += strlen(sym_name(&policydb, SYM_USERS,
> context->user - 1)) + 1;
>  	*scontext_len += strlen(sym_name(&policydb, SYM_ROLES,
> context->role - 1)) + 1;
>  	*scontext_len += strlen(sym_name(&policydb, SYM_TYPES,
> context->type - 1)) + 1;
> -	*scontext_len += mls_compute_context_len(context);
> +	*scontext_len += mls_compute_context_len(&policydb,
> context);
>  
>  	if (!scontext)
>  		return 0;
> @@ -1230,7 +1239,7 @@ static int context_struct_to_string(struct
> context *context, char **scontext, u3
>  		sym_name(&policydb, SYM_ROLES, context->role - 1),
>  		sym_name(&policydb, SYM_TYPES, context->type - 1));
>  
> -	mls_sid_to_context(context, &scontextp);
> +	mls_sid_to_context(&policydb, context, &scontextp);
>  
>  	*scontextp = 0;
>  
> @@ -1721,7 +1730,7 @@ static int security_compute_sid(u32 ssid,
>  
>  	/* Set the MLS attributes.
>  	   This is done last because it may allocate memory. */
> -	rc = mls_compute_sid(scontext, tcontext, tclass, specified,
> +	rc = mls_compute_sid(&policydb, scontext, tcontext, tclass,
> specified,
>  			     &newcontext, sock);
>  	if (rc)
>  		goto out_unlock;
> @@ -1935,7 +1944,7 @@ static int convert_context(u32 key,
>  
>  	/* Convert the MLS fields if dealing with MLS policies */
>  	if (args->oldp->mls_enabled && args->newp->mls_enabled) {
> -		rc = mls_convert_context(args->oldp, args->newp, c);
> +		rc = mls_convert_context(&policydb, args->oldp,
> args->newp, c);
>  		if (rc)
>  			goto bad;
>  	} else if (args->oldp->mls_enabled && !args->newp-
> >mls_enabled) {
> @@ -2043,8 +2052,9 @@ int security_load_policy(void *data, size_t
> len)
>  {
>  	struct policydb *oldpolicydb, *newpolicydb;
>  	struct sidtab oldsidtab, newsidtab;
> -	struct selinux_mapping *oldmap, *map = NULL;
> +	struct selinux_mapping *oldmap = NULL, *map = NULL;
>  	struct convert_context_args args;
> +	struct shared_current_mapping *new_mapping;
>  	u32 seqno;
>  	u16 map_size;
>  	int rc = 0;
> @@ -2055,9 +2065,22 @@ int security_load_policy(void *data, size_t
> len)
>  		rc = -ENOMEM;
>  		goto out;
>  	}
> +	new_mapping = kzalloc(sizeof(struct shared_current_mapping),
> +			      GFP_KERNEL);
> +	if (!new_mapping) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
>  	newpolicydb = oldpolicydb + 1;
>  
>  	if (!ss_initialized) {
> +		crm = kzalloc(sizeof(struct shared_current_mapping),
> +			      GFP_KERNEL);
> +		if (!crm) {
> +			rc = -ENOMEM;
> +			goto out;
> +		}
> +
>  		avtab_cache_init();
>  		ebitmap_cache_init();
>  		hashtab_cache_init();
> @@ -2071,8 +2094,8 @@ int security_load_policy(void *data, size_t
> len)
>  
>  		policydb.len = len;
>  		rc = selinux_set_mapping(&policydb, secclass_map,
> -					 &current_mapping,
> -					 &current_mapping_size);
> +					 &crm->current_mapping,
> +					 &crm-
> >current_mapping_size);
>  		if (rc) {
>  			policydb_destroy(&policydb);
>  			avtab_cache_destroy();
> @@ -2164,9 +2187,9 @@ int security_load_policy(void *data, size_t
> len)
>  	memcpy(&policydb, newpolicydb, sizeof(policydb));
>  	sidtab_set(&sidtab, &newsidtab);
>  	security_load_policycaps();
> -	oldmap = current_mapping;
> -	current_mapping = map;
> -	current_mapping_size = map_size;
> +	oldmap = crm->current_mapping;
> +	crm->current_mapping = map;
> +	crm->current_mapping_size = map_size;
>  	seqno = ++latest_granting;
>  	write_unlock_irq(&policy_rwlock);
>  
> @@ -2516,7 +2539,8 @@ int security_get_user_sids(u32 fromsid,
>  		ebitmap_for_each_positive_bit(&role->types, tnode,
> j) {
>  			usercon.type = j + 1;
>  
> -			if (mls_setup_user_range(fromcon, user,
> &usercon))
> +			if (mls_setup_user_range(&policydb, fromcon,
> +						 user, &usercon))
>  				continue;
>  
>  			rc = sidtab_context_to_sid(&sidtab,
> &usercon, &sid);
> @@ -2580,7 +2604,7 @@ int security_get_user_sids(u32 fromsid,
>   * cannot support xattr or use a fixed labeling behavior like
>   * transition SIDs or task SIDs.
>   *
> - * The caller must acquire the policy_rwlock before calling this
> function.
> + * The caller must hold rcu before calling this function.
>   */
>  static inline int __security_genfs_sid(const char *fstype,
>  				       char *path,
> @@ -2639,7 +2663,7 @@ static inline int __security_genfs_sid(const
> char *fstype,
>   * @sclass: file security class
>   * @sid: SID for path
>   *
> - * Acquire policy_rwlock before calling __security_genfs_sid() and
> release
> + * Hold rcu before calling __security_genfs_sid() and release
>   * it afterward.
>   */
>  int security_genfs_sid(const char *fstype,
> @@ -3214,7 +3238,8 @@ int selinux_audit_rule_init(u32 field, u32 op,
> char *rulestr, void **vrule)
>  	case AUDIT_SUBJ_CLR:
>  	case AUDIT_OBJ_LEV_LOW:
>  	case AUDIT_OBJ_LEV_HIGH:
> -		rc = mls_from_string(rulestr, &tmprule->au_ctxt,
> GFP_ATOMIC);
> +		rc = mls_from_string(&policydb, rulestr, &tmprule-
> >au_ctxt,
> +				     GFP_ATOMIC);
>  		if (rc)
>  			goto out;
>  		break;
> @@ -3464,9 +3489,10 @@ int security_netlbl_secattr_to_sid(struct
> netlbl_lsm_secattr *secattr,
>  		ctx_new.user = ctx->user;
>  		ctx_new.role = ctx->role;
>  		ctx_new.type = ctx->type;
> -		mls_import_netlbl_lvl(&ctx_new, secattr);
> +		mls_import_netlbl_lvl(&policydb, &ctx_new, secattr);
>  		if (secattr->flags & NETLBL_SECATTR_MLS_CAT) {
> -			rc = mls_import_netlbl_cat(&ctx_new,
> secattr);
> +			rc = mls_import_netlbl_cat(&policydb,
> &ctx_new,
> +						   secattr);
>  			if (rc)
>  				goto out;
>  		}
> @@ -3526,8 +3552,8 @@ int security_netlbl_sid_to_secattr(u32 sid,
> struct netlbl_lsm_secattr *secattr)
>  
>  	secattr->attr.secid = sid;
>  	secattr->flags |= NETLBL_SECATTR_DOMAIN_CPY |
> NETLBL_SECATTR_SECID;
> -	mls_export_netlbl_lvl(ctx, secattr);
> -	rc = mls_export_netlbl_cat(ctx, secattr);
> +	mls_export_netlbl_lvl(&policydb, ctx, secattr);
> +	rc = mls_export_netlbl_cat(&policydb, ctx, secattr);
>  out:
>  	read_unlock(&policy_rwlock);
>  	return rc;
> diff --git a/security/selinux/ss/services.h
> b/security/selinux/ss/services.h
> index 356bdd3..50c7ceb 100644
> --- a/security/selinux/ss/services.h
> +++ b/security/selinux/ss/services.h
> @@ -10,8 +10,6 @@
>  #include "policydb.h"
>  #include "sidtab.h"
>  
> -extern struct policydb policydb;
> -
>  void services_compute_xperms_drivers(struct extended_perms *xperms,
>  				struct avtab_node *node);
>  
> @@ -19,4 +17,3 @@ void services_compute_xperms_decision(struct
> extended_perms_decision *xpermd,
>  					struct avtab_node *node);
>  
>  #endif	/* _SS_SERVICES_H_ */
> -
