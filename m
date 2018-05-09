Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964949AbeEISvI convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 14:51:08 -0400
Received: from smtp1-3.goneo.de ([85.220.129.32]:33663 "EHLO smtp1-3.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935528AbeEISvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 14:51:06 -0400
X-Spam-Flag: NO
X-Spam-Score: -2.773
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 13/18] wait: wait.h: Get rid of a kernel-doc/Sphinx
 warnings
From: Markus Heiser <markus.heiser@darmarit.de>
In-Reply-To: <20180509123540.083b61d2@lwn.net>
Date: Wed, 9 May 2018 20:50:56 +0200
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <B01BA9C9-2EB8-4B02-A78A-21CACC78143B@darmarit.de>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
 <6b9b3184cbfabab1ad89c974ddf1c61631e8f1bf.1525684985.git.mchehab+samsung@kernel.org>
 <20180509084120.GF12217@hirez.programming.kicks-ass.net>
 <20180509084518.247650e2@lwn.net>
 <20180509152026.GA12198@hirez.programming.kicks-ass.net>
 <20180509123540.083b61d2@lwn.net>
To: Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 09.05.2018 um 20:35 schrieb Jonathan Corbet <corbet@lwn.net>:
> 
>> Why should I care for people not using text editors to write code?

Eh? .. why must readers write code?

We have rules how to write kernel-doc markup since the beginning of the century.
If you do not want to contribute kernel-doc markups, then just leave it, change
your comment start-tag to

 /*

and feel free to type what ever you want. Sorry, but this discussion is superfluous.

-- Markus -
