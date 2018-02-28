Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964945AbeB1XW4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 18:22:56 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35248 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964783AbeB1XWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 18:22:54 -0500
Subject: Re: [PATCH v3 0/4] Split page_type out from mapcount
To: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org
References: <20180228223157.9281-1-willy@infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <06c145aa-db40-df72-b626-da9d45f9111d@infradead.org>
Date: Wed, 28 Feb 2018 15:22:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228223157.9281-1-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/2018 02:31 PM, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> I want to use the _mapcount field to record what a page is in use as.
> This can help with debugging and we can also expose that information to
> userspace through /proc/kpageflags to help diagnose memory usage (not
> included as part of this patch set).

Hey,

Will there be updates to tools/vm/ also, or are these a different set of
(many) flags?

thanks,
-- 
~Randy
