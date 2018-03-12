Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932533AbeCLVAz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 17:00:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932302AbeCLVAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 17:00:54 -0400
Subject: Re: [PATCH v4 6/6] test_sysctl: Add range clamping test
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
References: <1520885744-1546-1-git-send-email-longman@redhat.com>
 <1520885744-1546-7-git-send-email-longman@redhat.com>
 <20180312205355.GC4449@wotan.suse.de>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <0836c985-657a-b604-8c03-344839177055@redhat.com>
Date: Mon, 12 Mar 2018 17:00:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180312205355.GC4449@wotan.suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2018 04:53 PM, Luis R. Rodriguez wrote:
> On Mon, Mar 12, 2018 at 04:15:44PM -0400, Waiman Long wrote:
>> Add a range clamping test for the msgmni sysctl parameter to verify
> No! We don't want to test production values, please add a new test
> entry which is similar but does *not* modify system production values!
>
>   Luis

Oh, I see. Will update the test accordingly.

Cheers,
Longman
