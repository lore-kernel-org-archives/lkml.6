Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932255AbeCLWMt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 18:12:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751282AbeCLWMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 18:12:48 -0400
Subject: Re: [PATCH v4 2/6] proc/sysctl: Check for invalid flags bits
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
References: <1520885744-1546-1-git-send-email-longman@redhat.com>
 <1520885744-1546-3-git-send-email-longman@redhat.com>
 <20180312135204.d56f7f1e64c96cf20786eb28@linux-foundation.org>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <42c1606b-304e-8cd5-d532-68a403a99dce@redhat.com>
Date: Mon, 12 Mar 2018 18:12:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180312135204.d56f7f1e64c96cf20786eb28@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2018 04:52 PM, Andrew Morton wrote:
> On Mon, 12 Mar 2018 16:15:40 -0400 Waiman Long <longman@redhat.com> wrote:
>
>> Checking code is added to check for invalid flags in the ctl_table
>> and return error if an unknown flag is used.
> Why?  What's wrong with the old code, what value does this change add,
> etc.

This is an additional checking code requested by Luis.

Cheers,
Longman
