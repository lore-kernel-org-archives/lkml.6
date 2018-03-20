Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751320AbeCTQfL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:35:11 -0400
Received: from ucol19pa12.eemsg.mail.mil ([214.24.24.85]:42186 "EHLO
        ucol19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbeCTQfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:35:08 -0400
X-IronPort-AV: E=Sophos;i="5.48,336,1517875200";
   d="scan'208";a="520248672"
X-IronPort-AV: E=Sophos;i="5.48,336,1517875200";
   d="scan'208";a="9923277"
IronPort-PHdr: =?us-ascii?q?9a23=3AZsKiFxDFyY8ahTyKcYPoUyQJP3N1i/DPJgcQr6Af?=
 =?us-ascii?q?oPdwSP39r8+wAkXT6L1XgUPTWs2DsrQY07GQ6/iocFdDyK7JiGoFfp1IWk1Nou?=
 =?us-ascii?q?QttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBAj0OxZr?=
 =?us-ascii?q?KeTpAI7SiNm82/yv95HJbAhEmDSwbaluIBmqsA7cqtQYjYx+J6gr1xDHuGFIe+?=
 =?us-ascii?q?NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S6dYDCk9PGAu+MLrrxjD?=
 =?us-ascii?q?QhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/VC+85Kl3VhDnlC?=
 =?us-ascii?q?YHNyY48G7JjMxwkLlbqw+lqxBm3oLYfJ2ZOP94c6zTZ9MaQXdKUNhXWSJPH4iw?=
 =?us-ascii?q?a5IDA/QdMepdqYT2ulkAogakBQS0Ge3h1DFIiH/106M03esuHgPJ0xAvEd8VrH?=
 =?us-ascii?q?TZr8/4OLsOXe27zqTFyyjIYfNM2Tf67YjFag0voe2SUrJoccre108vHB7YgFWV?=
 =?us-ascii?q?s4PlOzeV2foNsmOG6OdgTv+gi3U8pgFtojmg2scsio7TioIT0VDL7z91wIkyJd?=
 =?us-ascii?q?2mUUN2Z8OvHphItyyCKod7TcwvT3totSon0LEKp5G2cDYQxJg6wRPUduaJfJKS?=
 =?us-ascii?q?4h35UeacOTJ4hHV4d72hnxuy6k2gyvHkVsmzzVZKsjJJktnSuXAJ0Bze8tSHRe?=
 =?us-ascii?q?Fn/kegxDaPzBrf6v1EIE8olarbLIQtwrgsmZoIrUvPBCr2mETyjKOOd0Uk/Pan?=
 =?us-ascii?q?6/j/b7n7qZKROJV4hwHjPqg0hMCyDvo0PhITU2SD/OSzzrzj/Un3QLVQif02l7?=
 =?us-ascii?q?HUsIvHKsQAvaO5Hw9U3Zoj6xa4FTum1s8YkmMdIFJKfxKHkZDlO0vSL/DgEfe/?=
 =?us-ascii?q?n1OsnS9ox//cO73uHJPNLmPAkLbhZrty909cyBEvwtBY/Z5bFrYBIPfrUE/rqN?=
 =?us-ascii?q?PYFgM5MxCzw+v/FNVyzIAeWWWJAqCEKqPdq0SF6f4uI+mXeIAVvyzxJOQi5/7r?=
 =?us-ascii?q?lXU5g0MSfbG13ZsLb3C1BvRmI12Dbnf3g9YAEXsKvg0kTODwlFKCVjtTbW6oX6?=
 =?us-ascii?q?0g/jE7FJ6mDYDbS4CzgbyBxiC7E4ZXZ29YDFCMEGnoe5+AW/cNbiKSP8BgniYD?=
 =?us-ascii?q?Vbi7RI8tzwyutAziwbp9MuXU4jEYtY7k1NVt/eLTjxcy+iFvAsuHyWGNSXx7kX?=
 =?us-ascii?q?gSSzArwq91uVZ9xUub0ahkn/xYEsRe5+lOUgghLpPcy/Z1C9bvVQLFYNiISEyq?=
 =?us-ascii?q?QtO4DjEtVtgx2cMBY15hG9W+iRDOxyurA7gVl7ORHpw56abc33n3J8ZgxHfKzr?=
 =?us-ascii?q?chj184TctTL2Gmh7Vw9w3JC4HVlEWZkr6gdb4A0y7V6GeD0W2OsVlEXw53S6XK?=
 =?us-ascii?q?Rm4QZlfNoNT96ELCSaWiCbI5PQtd0cSCMLdFasX1jVVaQ/fuINbebHi0m2iuHh?=
 =?us-ascii?q?aE3L2NYJDve2oB2SXSFlQLkwAJ8naALgU+CSKhrHjfDDxqD17gf0Ts8exmonOh?=
 =?us-ascii?q?UkA01x2Kb1Fm17et+x4Vg/2cS+8J3r0evSchpS50EU2j39LZFdWAvRBtfKZCbt?=
 =?us-ascii?q?Mn5ldIy2bZuxZ6Ppy6IKBonkQefBhvv0PyyxV3DZ1NkcwrrHMs0QpzJruU305G?=
 =?us-ascii?q?dzyExp3wJLLXJXfo/By1aK7ZxEve0NCI9acL8vg4rE/jvA6xHEo473pny8VV02?=
 =?us-ascii?q?eb5pjSCAoSUJTxUls49hRjpLHVfDM954XK2n1oKqS0rDDC1MwzBOc/yRavYc1f?=
 =?us-ascii?q?MKWaGw/2CcEaANKuKOMykVizch0EJPxS9LIzP86+c/uG2airPPtvnT6/lmRI/p?=
 =?us-ascii?q?xy0l+W9yp9Vu7J348Jw/Sf3gSaSjf8iEmuv9vpmYBLez4SBHCzySv6C45LYK19?=
 =?us-ascii?q?Y4ILBX2pI82tydV0n4TtVGJA9F6/G1MG39ekeBWMYFDk2Q1Q1EIXoWGomCeh0T?=
 =?us-ascii?q?N1nC0pobSF3CzI2evicAEKNXJKRGl5kVjsJpK4gMwdXEitdwIpjgeq5V7mx6hH?=
 =?us-ascii?q?o6RyN3HTTl1VfyjyNGxiSrG/tqeGY8JW7ZMotiJXUP6iblyAVrH9pB4a2Tv5H2?=
 =?us-ascii?q?RC3DA7ay2qupLhkhNkkGKSNmxzrHvCecxr3RfQ/sbcRf9K3joeQCl3kyXYCUam?=
 =?us-ascii?q?M9mu59WUmMSLjufraWOqSppJOQriyI6GryiqrTlpCBiymeuwi/XsEBMx1mnw0N?=
 =?us-ascii?q?w8BgvSqxOpWZXmz6S3N6pce0BsAFLto55hFppWjpo7hJZW32MTwJqS4yxUwi/I?=
 =?us-ascii?q?LdxH1PemPzI2TjkRzouQuVK91Q=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DZAAD6NrFa/wHyM5BeGQEBAQEBAQEBAQEBAQcBAQEBAYM?=
 =?us-ascii?q?jLYFYKINdihuNf0gGgQwpgRaUB4IShRwCg00hNBgBAgEBAQEBAQIBaiiCOCQBg?=
 =?us-ascii?q?kgBAQEBAyMECwFGEAkCEQMBAgECAh8HAgJPCAYNBgIBAReCTYIlDY4gm0CBbDq?=
 =?us-ascii?q?EboNtgg6BDIQrghWBDYJEDIJshE8hgx6CYQOMO4wCCY8zB402kWQeOIFSKwgCG?=
 =?us-ascii?q?AghD4J9gmOOJCQ0jiKCSQEBAQ?=
Subject: Re: [Non-DoD Source] Re: [PATCH v3 14/15] selinux: allow setxattr on
 rootfs so initramfs code can set them
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
 <1518813234-5874-17-git-send-email-takondra@cisco.com>
 <1519153284.14218.18.camel@tycho.nsa.gov>
 <alpine.LRH.2.00.1803101848580.24419@sjc-ads-6991.cisco.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ab0b8e50-a92e-9f36-5493-ddbd295ed182@tycho.nsa.gov>
Date: Tue, 20 Mar 2018 12:33:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.00.1803101848580.24419@sjc-ads-6991.cisco.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2018 10:07 PM, Victor Kamensky wrote:
> 
> 
> On Tue, 20 Feb 2018, Stephen Smalley wrote:
> 
>> On Fri, 2018-02-16 at 20:33 +0000, Taras Kondratiuk wrote:
>>> From: Victor Kamensky <kamensky@cisco.com>
>>>
>>> initramfs code supporting extended cpio format have ability to
>>> fill extended attributes from cpio archive, but if SELinux enabled
>>> and security server is not initialized yet, selinux callback would
>>> refuse setxattr made by initramfs code.
>>>
>>> Solution enable SBLABEL_MNT on rootfs even if secrurity server is
>>> not initialized yet.
>>
>> What if we were to instead skip the SBLABEL_MNT check in
>> selinux_inode_setxattr() if !ss_initialized?  Not dependent on
>> filesystem type.
> 
> Stephen, thank you for looking into this. Sorry, for dealyed reponse -
> I needed to find time to require context about these changes.
> 
> As you suggested I've tried this and it works:
> 
>> From 6bf35bd055fdb12e94f3d5188eccfdbaa30dbcf4 Mon Sep 17 00:00:00 2001
> From: Victor Kamensky <kamensky@cisco.com>
> Date: Fri, 9 Mar 2018 23:01:20 -0800
> Subject: [PATCH 1/2] selinux: allow setxattr on file systems if policy is not
>  loaded
> 
> initramfs code supporting extended cpio format have ability to
> fill extended attributes from cpio archive, but if SELinux enabled
> and security server is not initialized yet, selinux callback would
> refuse setxattr made by initramfs code because file system is not
> yet marked as one that support labeling (SBLABEL_MNT flag).
> 
> Solution do not refuse setxattr even if SBLABEL_MNT is not set
> for file systems when policy is not loaded yet.
> 
> Signed-off-by: Victor Kamensky <kamensky@cisco.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 819fd68..31303ed 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3120,7 +3120,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
>          return selinux_inode_setotherxattr(dentry, name);
> 
>      sbsec = inode->i_sb->s_security;
> -    if (!(sbsec->flags & SBLABEL_MNT))
> +    if (!(sbsec->flags & SBLABEL_MNT) && ss_initialized)
>          return -EOPNOTSUPP;
> 
>      if (!inode_owner_or_capable(inode))

I favor the first option.
