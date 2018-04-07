Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeDGCgv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 22:36:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751949AbeDGCgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 22:36:50 -0400
Date: Fri, 6 Apr 2018 21:36:46 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/livepatch: introduce tests
Message-ID: <20180407023646.k3gjrgjwzhwgu6fq@treble>
References: <1522266588-11806-1-git-send-email-joe.lawrence@redhat.com>
 <1522266588-11806-2-git-send-email-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1522266588-11806-2-git-send-email-joe.lawrence@redhat.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 03:49:48PM -0400, Joe Lawrence wrote:
> Add a few livepatch modules and simple target modules that the included
> regression suite can run tests against.
> 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  lib/Kconfig.debug                                  |  12 +
>  lib/Makefile                                       |   2 +
>  lib/livepatch/Makefile                             |  18 +
>  lib/livepatch/test_klp_atomic_replace.c            |  69 +++
>  lib/livepatch/test_klp_callbacks_busy.c            |  43 ++
>  lib/livepatch/test_klp_callbacks_demo.c            | 132 ++++++
>  lib/livepatch/test_klp_callbacks_demo2.c           | 104 ++++
>  lib/livepatch/test_klp_callbacks_mod.c             |  24 +
>  lib/livepatch/test_klp_livepatch.c                 |  62 +++
>  tools/testing/selftests/Makefile                   |   1 +
>  tools/testing/selftests/livepatch/Makefile         |   8 +
>  tools/testing/selftests/livepatch/config           |   1 +
>  tools/testing/selftests/livepatch/functions.sh     | 202 ++++++++
>  .../testing/selftests/livepatch/test-callbacks.sh  | 526 +++++++++++++++++++++
>  .../testing/selftests/livepatch/test-livepatch.sh  | 177 +++++++
>  .../selftests/livepatch/test-shadow-vars.sh        |  13 +
>  16 files changed, 1394 insertions(+)
>  create mode 100644 lib/livepatch/Makefile
>  create mode 100644 lib/livepatch/test_klp_atomic_replace.c
>  create mode 100644 lib/livepatch/test_klp_callbacks_busy.c
>  create mode 100644 lib/livepatch/test_klp_callbacks_demo.c
>  create mode 100644 lib/livepatch/test_klp_callbacks_demo2.c
>  create mode 100644 lib/livepatch/test_klp_callbacks_mod.c
>  create mode 100644 lib/livepatch/test_klp_livepatch.c
>  create mode 100644 tools/testing/selftests/livepatch/Makefile
>  create mode 100644 tools/testing/selftests/livepatch/config
>  create mode 100644 tools/testing/selftests/livepatch/functions.sh
>  create mode 100755 tools/testing/selftests/livepatch/test-callbacks.sh
>  create mode 100755 tools/testing/selftests/livepatch/test-livepatch.sh
>  create mode 100755 tools/testing/selftests/livepatch/test-shadow-vars.sh

I love this.  Nice work!

As you and Petr discussed, it would be nice to get rid of some of the
delays, and also the callback tests will be very important.

-- 
Josh
