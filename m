Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeBTTAL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 14:00:11 -0500
Received: from uphb19pa10.eemsg.mail.mil ([214.24.26.84]:43354 "EHLO
        USFB19PA13.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751678AbeBTTAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 14:00:09 -0500
X-IronPort-AV: E=Sophos;i="5.46,540,1511827200";
   d="scan'208";a="9572512"
IronPort-PHdr: =?us-ascii?q?9a23=3AogPACxMvZRgsgQs9NPAl6mtUPXoX/o7sNwtQ0KIM?=
 =?us-ascii?q?zox0K/X4pMbcNUDSrc9gkEXOFd2Cra4c0KyO6+jJYi8p2d65qncMcZhBBVcuqP?=
 =?us-ascii?q?49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx7xKRR6?=
 =?us-ascii?q?JvjvGo7Vks+7y/2+94fcbglUijexe69+IAmrpgjNq8cahpdvJLwswRXTuHtIfO?=
 =?us-ascii?q?pWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3sp683xtBnM?=
 =?us-ascii?q?VhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs5Qiqp4bt1RxD0iS?=
 =?us-ascii?q?cHLz85/3/Risxsl6JQvRatqwViz4LIfI2ZMfxzca3HfdMeWGFPQMBfWSJcCY+4?=
 =?us-ascii?q?docDEfYNMeNeooLgpVUBsAG+CBGvCu3yyjFGmHH40q800+s9Fg/J0wMuEskSsH?=
 =?us-ascii?q?nWttj5KL0fXfy3waTO0D7Nb+lW2TD46IXQbx4hve+DXapwccXPz0kkCh7LjlCK?=
 =?us-ascii?q?pozhOzOayOQMuHWc4up7SO2vkHUqqx1xozezxscsjZPFhoQOyl/e7yl5z4E1Jc?=
 =?us-ascii?q?OhRUN9fNWqE4NQujmHO4Z5Tc4uWWFltDsgxrEYtpO3YjIGxIkhyhXCcfKIaZKI?=
 =?us-ascii?q?7QjmVOuJJDd4g29qd6ynihap9Eig1vX8Vs6p0FZWtiZFksfDtnQK1xHL9siIUO?=
 =?us-ascii?q?F9/ka82TaUzQzT9uFFLlw0larcMZIhxKI/loEPvkjZGy/2mUH2gLeXdkUi5Oeo?=
 =?us-ascii?q?9/zqbqjpq5KTLYN5ihzyPr4wlsGwH+g0KBUCU3Ce+eum1b3j+UP5QK9Njv0ziq?=
 =?us-ascii?q?TZq43VJd8Aq66lAw5azoYj6xGlAzegy9QXh2MLLF1CeBKZl4TpIU3BIOjkDfej?=
 =?us-ascii?q?hFShiClkx+jcMb37A5XNNWPOkK/7crZn6k5c0xIzzdRF6J1IFL4NOvXzWlX+tN?=
 =?us-ascii?q?bAFB82LxS0w/r7CNV6zo4eQXiAArKdMK7JqV+H/P8vI+2VaI8Qvzb9LOIl6OD0?=
 =?us-ascii?q?gXAlnl8deLGj3YELZ3CgAvRmP0KZbGLjg9gfCGsKugs+TOr3iFyNSDJceXmzX7?=
 =?us-ascii?q?4i6TEhDoKpF4PDS5uxj7yAxye0AppWanpaBVCLFHfib5+EVOsUaCKOPs9hlSQJ?=
 =?us-ascii?q?VbygS48nyBGvuxb2y6F5IeXI5y0Yr5Pj1MR15uHKkBEy8iF7D9mZ026TVGx0gG?=
 =?us-ascii?q?wISCEs3Kxlokxy1E2D0a5mjPxcD9BT4OlJUggiP57G0+N6E8zyWh7GftqRTFam?=
 =?us-ascii?q?Q9OmASw+T94owN8BfVx9G9O8gRDHxCeqHbAVmKKRBJAu8aLTwWLxJ8BjxHbCzq?=
 =?us-ascii?q?UhiEMmQsRXP228mqF/7xTTB5LOk0iBk6aqdKIc3DPC9Wua0GWOu11XXRVuUaXK?=
 =?us-ascii?q?Q38ffFHardfn6UPYSb+hF7AnPhFGyc6YJatAcsfpgkleRPf/JNTeZHq8m2SqCh?=
 =?us-ascii?q?aN2LyMapHqe2Yd3SjGFEcEkhsT8mqBNQQkGiihpGfeBiR0FV3ze0Ps7fV+qHSj?=
 =?us-ascii?q?Q081yQGKblFh16Cv9R4Qi/ycUOge3qwLuCg/sTV4BlW90MzMC9qGuQVheL9QYd?=
 =?us-ascii?q?Qn4FdIzWjZrRByPoS8L6B+gV4TawZ3sFnr1xppEYVMi8YroGkvzAVuLKKXzk9O?=
 =?us-ascii?q?dzOC0pD2IbDXJWzy8wqua67SwF3RzNGW+qIX4vQit1rjpB2pFlYl83h/z9ZV1G?=
 =?us-ascii?q?Gc6Y7UAwoOSp/xVkg29x5gq7HcfCY9+5ve1WdwPqmsrj/Cx9UpCfMkyxanf9dQ?=
 =?us-ascii?q?KrmEGRT2E80bAciuNeMrl0K3bhICIu9S6LQ4P8K9ePuDwqKkIOFgnDe+h2Rd/I?=
 =?us-ascii?q?99yl6M9zZ7SuPQxZYFxOqX0xCDVzjmileur8T3lp5EZD0IGGqw1zTkDpZLZqJu?=
 =?us-ascii?q?ZYYLFXuuI8qvy9pknZ7tXWNX+UW5CFMc3s+mZAGdY0bg0gJOzU4Xu2ComTOkzz?=
 =?us-ascii?q?xolDEktrSf3C3Uw+TlbxcGO3BERG9jjVfyO4S0i9EaXE61bwkmjhel4lz6x6dB?=
 =?us-ascii?q?qKRiLGnZWV1IcDTuL2F+TquwsaKPY85X6JwyqihWUeS9YUydSr7nuRcVzyTjH2?=
 =?us-ascii?q?5GzjAhaz6qoon5nwB9iG+FMHZ8tnnZecZ2xRjC/tzTX+Vc0SYHRCljlTbXAUKw?=
 =?us-ascii?q?MMWu/dWRxN//tbWCXnioTdVwdi/n14qctTa4rTl2CB64mfypk/XsEBMx1mnw0N?=
 =?us-ascii?q?w8EW2CjFC0WoT32r7yGOR5f08iTAv888NSCJBilZF2j5YVjzxSr5Hdw3sdli+n?=
 =?us-ascii?q?L9RB3orsYXwMW3gPwtjI8E7iwkIlM3Hfg8rQTHORiuFsfda/a2UQknY09cZGIK?=
 =?us-ascii?q?6O6rBO2yd49B7wlwXbKdx0mDsZxOpmvGQdickNsQwhyiiMRLYfAR8cdQntkhXA?=
 =?us-ascii?q?3de+pb8fMHSocbGq/E5/m82xSq+Erx0aWXz8PJwlGHk0pud4NlvQ0HT1oqrjYt?=
 =?us-ascii?q?PdcZpHvRqOmRrcp+xKLtQ3m+ZcwWJFMGfwpjUAwMs2hhxn29nuvoGCJn4r4+S8?=
 =?us-ascii?q?CRtVPT38Yesc/zjsieBVmcPAjK61GZA0ISkGRJvlS7qTFTsWsfn2f1KVHCYUtm?=
 =?us-ascii?q?aQGb2ZGxSWrkhhsSScQNiQK3iLKSxBnp1ZTx6HKRka2VpMUQ=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CyAQAub4xa/wHyM5BcGQEBAQEBAQEBAQEBAQcBAQEBAYM?=
 =?us-ascii?q?iLYFWKINomCxFAQEBBoE0gReYX4VFAoJsWBQBAgEBAQEBAQIBaiiCOCQBgkYBA?=
 =?us-ascii?q?QEBAgEjBFIQCw4HAwICJgICVwYBEhuHZ4IUBQitNYFtOoQYAWmDe4ITAQEBAQE?=
 =?us-ascii?q?BBAEBAQEBAQEhgQ+Df4IogQ+FXoUNgy2CZQWSUoEWkE0JlgqUR5lbNiKBUSsIA?=
 =?us-ascii?q?hgIIQ+CfYMJgTIBWCM3jR0BAQE?=
Message-ID: <1519153284.14218.18.camel@tycho.nsa.gov>
Subject: Re: [PATCH v3 14/15] selinux: allow setxattr on rootfs so initramfs
 code can set them
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
Date: Tue, 20 Feb 2018 14:01:24 -0500
In-Reply-To: <1518813234-5874-17-git-send-email-takondra@cisco.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
         <1518813234-5874-17-git-send-email-takondra@cisco.com>
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
> initramfs code supporting extended cpio format have ability to
> fill extended attributes from cpio archive, but if SELinux enabled
> and security server is not initialized yet, selinux callback would
> refuse setxattr made by initramfs code.
> 
> Solution enable SBLABEL_MNT on rootfs even if secrurity server is
> not initialized yet.

What if we were to instead skip the SBLABEL_MNT check in
selinux_inode_setxattr() if !ss_initialized?  Not dependent on
filesystem type.

> 
> Signed-off-by: Victor Kamensky <kamensky@cisco.com>
> ---
>  security/selinux/hooks.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 8644d864e3c1..f3fe65589f02 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -706,6 +706,18 @@ static int selinux_set_mnt_opts(struct
> super_block *sb,
>  
>  	if (!ss_initialized) {
>  		if (!num_opts) {
> +			/*
> +			 * Special handling for rootfs. Is genfs but
> supports
> +			 * setting SELinux context on in-core
> inodes.
> +			 *
> +			 * Chicken and egg problem: policy may
> reside in rootfs
> +			 * but for initramfs code to fill in
> attributes, it
> +			 * needs selinux to allow that.
> +			 */
> +			if (!strncmp(sb->s_type->name, "rootfs",
> +				     sizeof("rootfs")))
> +				sbsec->flags |= SBLABEL_MNT;
> +
>  			/* Defer initialization until
> selinux_complete_init,
>  			   after the initial policy is loaded and
> the security
>  			   server is ready to handle calls. */
