Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbeCUPRt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:17:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752385AbeCUPRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:17:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD842177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 21 Mar 2018 11:17:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tim Tianyang Chen <tianyang.chen@oracle.com>
Cc: linux-kernel@vger.kernel.org, dhaval.giani@oracle.com
Subject: Re: [PATCH 3/3] Ktest: add email options to sample.config
Message-ID: <20180321111745.57e609a0@gandalf.local.home>
In-Reply-To: <1513380011-15274-4-git-send-email-tianyang.chen@oracle.com>
References: <1513380011-15274-1-git-send-email-tianyang.chen@oracle.com>
        <1513380011-15274-4-git-send-email-tianyang.chen@oracle.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2017 15:20:11 -0800
Tim Tianyang Chen <tianyang.chen@oracle.com> wrote:

> A block of email options is added under the optional config section.
> 
> Suggested-by: Dhaval Giani <dhaval.giani@oracle.com>
> Signed-off-by: Tim Tianyang Chen <tianyang.chen@oracle.com>
> ---
>  sample.conf | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/sample.conf b/sample.conf
> index 6c58cd8bbbae..0571acf2179b 100644
> --- a/sample.conf
> +++ b/sample.conf
> @@ -396,6 +396,16 @@
>  
>  #### Optional Config Options (all have defaults) ####
>  
> +# Email options for receiving notifications. Users must setup
> +# the specified mailer prior to using this feature.

Each one should have a separate comment.

> +#
> +#MAILTO = ""

as this one:

# (default undefined)
#MAILTO =

-- Steve

> +#MAILER = sendmail
> +#EMAIL_ON_ERROR = 1
> +#EMAIL_WHEN_FINISHED = 1
> +#EMAIL_WHEN_STARTED = 0
> +#EMAIL_WHEN_CANCELED = 0
> +
>  # Start a test setup. If you leave this off, all options
>  # will be default and the test will run once.
>  # This is a label and not really an option (it takes no value).
