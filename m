Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbeBPD5J (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 22:57:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:48246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751121AbeBPD5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 22:57:08 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D9C21777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 15 Feb 2018 22:57:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: changbin.du@intel.com
Cc: corbet@lwn.net, mingo@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Documentation: convert trace/ftrace-design.txt to
 rst format
Message-ID: <20180215225705.58984492@vmware.local.home>
In-Reply-To: <1518750739-12514-3-git-send-email-changbin.du@intel.com>
References: <1518750739-12514-1-git-send-email-changbin.du@intel.com>
        <1518750739-12514-3-git-send-email-changbin.du@intel.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2018 11:12:18 +0800
changbin.du@intel.com wrote:

> From: Changbin Du <changbin.du@intel.com>
> 
> Signed-off-by: Changbin Du <changbin.du@intel.com>
> ---
>  .../trace/{ftrace-design.txt => ftrace-design.rst} | 248 +++++++++++----------
>  Documentation/trace/index.rst                      |   2 +
>  2 files changed, 137 insertions(+), 113 deletions(-)
>  rename Documentation/trace/{ftrace-design.txt => ftrace-design.rst} (75%)
> 
> diff --git a/Documentation/trace/ftrace-design.txt b/Documentation/trace/ftrace-design.rst
> similarity index 75%
> rename from Documentation/trace/ftrace-design.txt
> rename to Documentation/trace/ftrace-design.rst
> index a273dd0..0f32a85 100644
> --- a/Documentation/trace/ftrace-design.txt
> +++ b/Documentation/trace/ftrace-design.rst
> @@ -1,6 +1,8 @@
> -		function tracer guts
> -		====================
> -		By Mike Frysinger
> +======================
> +Function Tracer Design
> +======================
> +
> +:Author: Mike Frysinger
>  

This document is out of date, and I rather have it updated before we
make it more "available" elsewhere.

-- Steve
