Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA43C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9049220883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbfAIKp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:45:58 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:56775 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729607AbfAIKp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:45:57 -0500
Received: from 79.184.254.168.ipv4.supernova.orange.pl (79.184.254.168) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 87062205107ada3a; Wed, 9 Jan 2019 11:45:54 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Otto Sabart <ottosabart@seberm.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/1] doc: trace: fix reference to cpuidle documentation file
Date:   Wed, 09 Jan 2019 11:45:09 +0100
Message-ID: <3605332.KXf7BibVrA@aspire.rjw.lan>
In-Reply-To: <f9650f8f9d085a47caf3db1baa41310d6646ae00.1546991610.git.ottosabart@seberm.com>
References: <f9650f8f9d085a47caf3db1baa41310d6646ae00.1546991610.git.ottosabart@seberm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, January 9, 2019 12:56:51 AM CET Otto Sabart wrote:
> 
> --LZvS9be/3tNcYl/X
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> Old cpuidle/sysfs.txt file was replaced in aa5eee355b46. So, refer to
> an updated file.
> 
> Fixes: aa5eee355b46 ("Documentation: admin-guide: PM: Add cpuidle document")
> Signed-off-by: Otto Sabart <ottosabart@seberm.com>
> ---
>  Documentation/trace/coresight-cpu-debug.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/trace/coresight-cpu-debug.txt b/Documentation/tr=
> ace/coresight-cpu-debug.txt
> index 89ab09e78e8d..f07e38094b40 100644
> --- a/Documentation/trace/coresight-cpu-debug.txt
> +++ b/Documentation/trace/coresight-cpu-debug.txt
> @@ -165,7 +165,7 @@ Do some work...
>  The same can also be done from an application program.
> =20
>  Disable specific CPU's specific idle state from cpuidle sysfs (see
> -Documentation/cpuidle/sysfs.txt):
> +Documentation/admin-guide/pm/cpuidle.rst):
>  # echo 1 > /sys/devices/system/cpu/cpu$cpu/cpuidle/state$state/disable

Applied, thanks!

