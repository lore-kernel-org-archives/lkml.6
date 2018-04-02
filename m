Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeDBPwg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 11:52:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751415AbeDBPwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 11:52:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1C920838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 2 Apr 2018 11:52:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tracing: Uninitialized variable in
 create_tracing_map_fields()
Message-ID: <20180402115232.2319bcef@gandalf.local.home>
In-Reply-To: <1522245880.520.1.camel@tzanussi-mobl.amr.corp.intel.com>
References: <20180328114815.GC29050@mwanda>
        <1522245880.520.1.camel@tzanussi-mobl.amr.corp.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Mar 2018 09:04:40 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> Yes, this should definitely be initialized to 0, thanks for the patch!
> 
> Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Thanks, I applied it and will push to git after it has succeeded in
testing.

-- Steve
