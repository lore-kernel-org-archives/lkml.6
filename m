Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbeDJViK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 17:38:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43436 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751770AbeDJViG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 17:38:06 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH 1/1 v2] vmscan: Support multiple kswapd threads per
 node
From: Buddy Lumpkin <buddy.lumpkin@oracle.com>
In-Reply-To: <20180406073809.GF8286@dhcp22.suse.cz>
Date: Tue, 10 Apr 2018 14:37:27 -0700
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, hannes@cmpxchg.org,
        riel@surriel.com, mgorman@suse.de, willy@infradead.org,
        akpm@linux-foundation.org
Content-Transfer-Encoding: 7bit
Message-Id: <9FBD9A5F-8381-4810-A480-806632EBBDFC@oracle.com>
References: <1522878594-52281-1-git-send-email-buddy.lumpkin@oracle.com>
 <20180405061015.GU6312@dhcp22.suse.cz>
 <99DC1801-1ADC-488B-BA8D-736BCE4BA372@oracle.com>
 <20180406073809.GF8286@dhcp22.suse.cz>
To: Michal Hocko <mhocko@kernel.org>
X-Mailer: Apple Mail (2.3273)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8859 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804100199
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Apr 6, 2018, at 12:38 AM, Michal Hocko <mhocko@kernel.org> wrote:
> 
> On Thu 05-04-18 23:25:14, Buddy Lumpkin wrote:
>> 
>>> On Apr 4, 2018, at 11:10 PM, Michal Hocko <mhocko@kernel.org> wrote:
>>> 
>>> On Wed 04-04-18 21:49:54, Buddy Lumpkin wrote:
>>>> v2:
>>>> - Make update_kswapd_threads_node less racy
>>>> - Handle locking for case where CONFIG_MEMORY_HOTPLUG=n
>>> 
>>> Please do not repost with such a small changes. It is much more
>>> important to sort out the big picture first and only then deal with
>>> minor implementation details. The more versions you post the more
>>> fragmented and messy the discussion will become.
>>> 
>>> You will have to be patient because this is a rather big change and it
>>> will take _quite_ some time to get sorted.
>>> 
>>> Thanks!
>>> -- 
>>> Michal Hocko
>>> SUSE Labs
>>> 
>> 
>> 
>> Sorry about that, I actually had three people review my code internally,
>> then I managed to send out an old version. 100% guilty of submitting
>> code when I needed sleep. As for the change, that was in response
>> to a request from Andrew to make the update function less racy.
>> 
>> Should I resend a correct v2 now that the thread exists?
> 
> Let's just discuss open questions for now. Specifics of the code are the
> least interesting at this stage.
> 
> If you want some help with the code review, you can put it somewhere in
> the git tree and send a reference for those who are interested.
> -- 
> Michal Hocko
> SUSE Labs

Ok, I will go back through the thread and make sure all questions and
concerns have been addressed.
