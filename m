Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751670AbeCTQjO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:39:14 -0400
Received: from ucol19pa10.eemsg.mail.mil ([214.24.24.83]:54603 "EHLO
        UCOL19PA10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeCTQjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:39:12 -0400
X-IronPort-AV: E=Sophos;i="5.48,336,1517875200";
   d="scan'208";a="470323080"
X-IronPort-AV: E=Sophos;i="5.48,336,1517875200";
   d="scan'208";a="9922901"
IronPort-PHdr: =?us-ascii?q?9a23=3AjVEK1hOcbK0KiQg5BEMl6mtUPXoX/o7sNwtQ0KIM?=
 =?us-ascii?q?zox0K/rzpMbcNUDSrc9gkEXOFd2Cra4c0KyO6+jJYi8p2d65qncMcZhBBVcuqP?=
 =?us-ascii?q?49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx7xKRR6?=
 =?us-ascii?q?JvjvGo7Vks+7y/2+94fcbglUijexe69+IAmrpgjNq8cahpdvJLwswRXTuHtIfO?=
 =?us-ascii?q?pWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3sp683xtBnM?=
 =?us-ascii?q?VhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs5Qiqp4bt1RxD0iS?=
 =?us-ascii?q?cHLz85/3/Risxsl6JQvRatqwViz4LIfI2ZMfxzca3HfdMeWGFPQMBfWSJcCY+4?=
 =?us-ascii?q?docDEfYNMeNeooLgpVUBsAG+CBGxCu3xxD9Ghnz406M03OsuEw7JwAMuEskSsH?=
 =?us-ascii?q?nXttj5KLseXO63waTO0D7Nb+lW2TD46IXQbx4hve+DXapwccXPz0kkCh7LjlCK?=
 =?us-ascii?q?pozhOzOayOQMuHWc4up7SO2vkHUqqx1xozezxscsjZPFhoQOyl/e7yl5z4E1Jc?=
 =?us-ascii?q?OhRUN9fNWqE4NQujmHO4Z5Tc4uWWFltDsgxrEYtpO3YjIGxIkhyhXCcfKIaZKI?=
 =?us-ascii?q?7QjmVOuJJDd4g29qd6ynihap9Eig1vX8Vs6p0FZWtiZFksfDtnQK1xHL9siIUO?=
 =?us-ascii?q?F9/ka82TaUzQzT9uFFLlw0larcMZIhxKI/loEPvkjZGy/2mUH2gLeXdkUi5Oeo?=
 =?us-ascii?q?9/zqbqjpq5KTLYN5ihzyPr4wlsGwH+g0KBUCU3Ce+eum1b3j+UP5QK9Njv0ziq?=
 =?us-ascii?q?TZq43VJd8Aq66lAw5azoYj6xGlAzegy9QXh2MLLF1CeBKZl4TpIU3BIOjkDfej?=
 =?us-ascii?q?hFShiDRryOrDPrL/BJXNNXvDkbf6cLlh6k5c0xY8zddF651IDbEBJer5WlXtu9?=
 =?us-ascii?q?zAEh85Lwu0zv77CNpn1YMeXmSPDbKDMKzIqlKH+uMvI/KQa48SojryN/8l5/v2?=
 =?us-ascii?q?h38jhVAdZbWp3YcQaH2gHvRmO1+WbGHtg9YBDWcKuRA+QPb2h12FVD5Zf2yyUL?=
 =?us-ascii?q?4k5jEnFIKmCp/ORp6sgLyb2ye2BZxXaX5AClCND3fkbYGEW/YKaCKPLc5tiDsE?=
 =?us-ascii?q?VaKuS4M7yBGutxfwy6B7IerM5i0YqZXj2cBv6O3JkxE96Cd5AN6H02GLUm57hX?=
 =?us-ascii?q?kESCIo06pnu0xy1k+D0bRkg/xfDdFT/fRJXRwhOJ7Y1eN6Dc39WgbfcdaJUlqm?=
 =?us-ascii?q?RMupAS0pRNIr39AOe1p9G8mljh3b3iuqBL8VmKaRBJEv9qLc3n7xJ9tyynrcyq?=
 =?us-ascii?q?khiUcpQtdVOW2nnaF/8hLfCJLOk0Wcj6yqb7gT3DbR9GefymqDpF1XUAlqUare?=
 =?us-ascii?q?Q38felDbrdD350PEVbOuD6ooMhdZw86YNqRKcsHpjUlBRPr7OtTReWexlHmrBR?=
 =?us-ascii?q?qSyLKAdo/qdHkY3CrDFEcEkxoc/XCdOAgxAyeuuWPeDDh0GV3zZEPs9PF0qGmn?=
 =?us-ascii?q?QU8s0wGKc0ph2qK0+h4ThPycV+kT0agBuCcvsDV5B0i9393IBNqavQZhf7tTYc?=
 =?us-ascii?q?k74FhZ0WLVrQt9PoavL6p6nF4Rbxx3v1/y1xVwEohAlckqrHU3zAt9MK6XzVRB?=
 =?us-ascii?q?eC+D0JDuNb3YNHPy8Aqsa6HIwFHe1siZ+qMV5PQ/sVXjsxmjFlA+/HV/z9lVz3?=
 =?us-ascii?q?yc643ODAoTV5LxT0k2+wF5p77EeCk94Z3b1Xl3PKmqvT/NxcgpCPEmyhm+Zddf?=
 =?us-ascii?q?Nr2LFAvoH80dHciuJ/Qgm0K1YRIcIOBS6Kk0Mtuid/uH3q6rIelhkCu9jWtZ/I?=
 =?us-ascii?q?99z1iM9ytgSu/IxpoFxvaY0RaaVzf4klisqd73mY9aajEIBGa/yjbrBJRXZqJs?=
 =?us-ascii?q?eYYHE2CuI9e4xt9mnZ7iR2ZY9EK/B1MBwMKodgSdY0X53Q1R00QXvHOmlTKmwD?=
 =?us-ascii?q?17jzEmsLCf3CrUzOTmbxcIJm9LRHJ+glfrO4S7k9caXE2wZQgziBSl/Vr6x7Rc?=
 =?us-ascii?q?pKlnN2ncW1pIfyztImF6SKSwq76Cb9dK6JMvtiVXSvqzbUqGRb76phsQyznjEH?=
 =?us-ascii?q?dGxDAnazGqvY30kAJiiG2HNnZzrWHZdNpoxRjF/tzcROVR3iICRCZilTbYGEKw?=
 =?us-ascii?q?P96z/dWbxN//tbWAVmm9UYcbUiDuwIWbtzrzsW5jBBC5hPOistbmCgM9lyT80o?=
 =?us-ascii?q?85ez/PqUPHfoTz16m8edlid01sCU60v9F2Aalig4Awg9cWwnFciZKLqylU2Vzv?=
 =?us-ascii?q?OMlWjPqtJEEGQiQGlpuMulDo?=
X-IPAS-Result: =?us-ascii?q?A2DUAADPNbFa/wHyM5BeGQEBAQEBAQEBAQEBAQcBAQEBAYM?=
 =?us-ascii?q?jLYFYKINdihuNf0gGgTWBFpQHghKFHAKDTSE0GAECAQEBAQEBAgFqKII4JAGCS?=
 =?us-ascii?q?AEBAQECASMPAUYQCQIRAwECAQICHwcCAk8IBg0GAgEBgmSCJQUIjh+bQIImhG6?=
 =?us-ascii?q?DbYIOgQyEK4IVgQ2CRIJFM4Rwgx6CYQOMO4wCCY8zB4FOi2iHQ4ohHjiBUisIA?=
 =?us-ascii?q?hgIIQ+CfYIyGxaOJCQ0jiIFgkQBAQE?=
Subject: Re: [Non-DoD Source] Re: [PATCH v3 15/15] selinux: delay sid
 population for rootfs till init is complete
To: Victor Kamensky <kamensky@cisco.com>
Cc: Taras Kondratiuk <takondra@cisco.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Rob Landley <rob@landley.net>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James McMechan <james.w.mcmechan@gmail.com>, initramfs@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, xe-linux-external@cisco.com,
        Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
 <1518813234-5874-19-git-send-email-takondra@cisco.com>
 <1519152994.14218.15.camel@tycho.nsa.gov>
 <alpine.LRH.2.00.1803101900250.24419@sjc-ads-6991.cisco.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <fe13077c-b528-b42d-6fde-8637043f37bb@tycho.nsa.gov>
Date: Tue, 20 Mar 2018 12:30:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.00.1803101900250.24419@sjc-ads-6991.cisco.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2018 10:08 PM, Victor Kamensky wrote:
> 
> 
> On Tue, 20 Feb 2018, Stephen Smalley wrote:
> 
>> On Fri, 2018-02-16 at 20:33 +0000, Taras Kondratiuk wrote:
>>> From: Victor Kamensky <kamensky@cisco.com>
>>>
>>> With initramfs cpio format that supports extended attributes
>>> we need to skip sid population on sys_lsetxattr call from
>>> initramfs for rootfs if security server is not initialized yet.
>>>
>>> Otherwise callback in selinux_inode_post_setxattr will try to
>>> translate give security.selinux label into sid context and since
>>> security server is not available yet inode will receive default
>>> sid (typically kernel_t). Note that in the same time proper
>>> label will be stored in inode xattrs. Later, since inode sid
>>> would be already populated system will never look back at
>>> actual xattrs. But if we skip sid population for rootfs and
>>> we have policy that direct use of xattrs for rootfs, proper
>>> sid will be filled in from extended attributes one node is
>>> accessed and server is initialized.
>>>
>>> Note new DELAYAFTERINIT_MNT super block flag is introduced
>>> to only mark rootfs for such behavior. For other types of
>>> tmpfs original logic is still used.
>>
>> (cc selinux maintainers)
>>
>> Wondering if we shouldn't just do this always, for all filesystem
>> types.
> 
> Ok, I think it makes sense. The one that do not support xattrs
> will not reach selinux_inode_post_setxattr anyway. And try
> to cache sid while !ss_initialized is not good idea for any
> filesystem types.
> 
>> Also, I think this should likely also be done in
>> selinux_inode_setsecurity() for consistency.
> 
> I am not sure that I follow selinux_inode_setsecurity suggestion.
> selinux_inode_setsecurity is about permission check. And
> selinux_inode_post_setxattr deals with processing and setting
> side effects if xattr was "security.selinux", it does not
> matter what happens in selinux_inode_setsecurity if it
> returns access_ok, LSM will still call selinux_inode_post_setxattr
> and we would need to check and not produce any sid caching
> side effects if !ss_initialized.

selinux_inode_setsecurity is the vfs fallback for setting security
attributes when the filesystem/inode does not support setxattr itself,
and is also used by kernfs. 
So you need to update both selinux_inode_post_setxattr and selinux_inode_setsecurity
in the same way.

> 
> Sitll keeping logic in selinux_inode_post_setxattr, checked
> that the following with much simple code works too:
> 
>> From bfc54e4805f3059671417ff2cda1266bc68e18f9 Mon Sep 17 00:00:00 2001
> From: Victor Kamensky <kamensky@cisco.com>
> Date: Fri, 9 Mar 2018 23:06:08 -0800
> Subject: [PATCH 2/2] selinux: delay sid population in setxattr till policy
>  loaded
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
> Signed-off-by: Victor Kamensky <kamensky@cisco.com>
> ---
>  security/selinux/hooks.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 31303ed..4c13759 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3197,6 +3197,10 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
>          return;
>      }
> 
> +        if (!ss_initialized) {
> +                return;
> +        }
> +
>      rc = security_context_to_sid_force(value, size, &newsid);
>      if (rc) {
>          printk(KERN_ERR "SELinux:  unable to map context to SID"
