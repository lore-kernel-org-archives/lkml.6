Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752502AbeDFWGa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 18:06:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751679AbeDFWG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 18:06:29 -0400
Date: Fri, 6 Apr 2018 17:06:25 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] livepatch: Add an extra flag to distinguish
 registered patches
Message-ID: <20180406220625.joessemwohjzffdb@treble>
References: <20180323120028.31451-1-pmladek@suse.com>
 <20180323120028.31451-5-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180323120028.31451-5-pmladek@suse.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 01:00:24PM +0100, Petr Mladek wrote:
> @@ -528,6 +537,7 @@ static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute *attr,
>  		goto err;
>  	}
>  
> +
>  	if (patch->enabled == enabled) {
>  		/* already in requested state */
>  		ret = -EINVAL;

Extra newline.

-- 
Josh
