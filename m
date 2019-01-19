Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB68C5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463522087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbfASBqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 20:46:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:40336 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727422AbfASBqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 20:46:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 70E2CAE4C;
        Sat, 19 Jan 2019 01:46:30 +0000 (UTC)
Subject: Re: [PATCH v2] perf scripts python: Add Python 3 support to
 stackcollapse.py
To:     Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <1547718344-27382-1-git-send-email-s1seetee@linux.vnet.ibm.com>
 <1547718344-27382-13-git-send-email-s1seetee@linux.vnet.ibm.com>
From:   Tony Jones <tonyj@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=tonyj@suse.de; prefer-encrypt=mutual; keydata=
 mQGiBEkQmbwRBACDch7wo/RzlNt2HA8jLICsO2w8yOkJ7UTzHYNn3Q83Ro0qev2KokfE3EDw
 il+vam9CDR7jIDmswHqaMe0/O+UnZtO5PlDgylZcrwNwbBzHfm/KGejbi1RBGAoETrvcfwGi
 w83bR/aDnoRXY5Ho1uphQ05/065EMpbJOOBdn9qQ4wCgv2Q6C/QeYDGsxJPRO+20nLu5K00D
 /Rde4OTZ5biM+vb6ObTmgPNeiMrTwGpMokN7audIl7njwvD+lYrlgQjmDzcaPFz29rYWwT7g
 6t6hcFgjpU1he/v3qxeQlTJoi2+u5Mqj42z//49h6DqNjT859Z/6h5IwKBo/EZC17iBIlS2G
 VXAstNiZASGiaIlONozWJ/GSjUaRA/9wZTV1nXF/+xX+qmc7SvTg1w6jWyjxVumQLoq2SeA4
 1Sy5X2IATkAGCCjbeoQGnFdbOnHRSJdlTazObgwreqGPlPnIROpr9QESkfxsaCkDiZfpl0xk
 6X069QMZBEwGAWILHYXL9UqlOjniZaU2BkVA11JEdBhyQorC8T/ji1edc7QaVG9ueSBKb25l
 cyA8dG9ueWpAc3VzZS5kZT6IYAQTEQIAIAUCSRCZvAIbAwYLCQgHAwIEFQIIAwQWAgMBAh4B
 AheAAAoJELFYWyEf4koXGmYAoKCnbv9dhAB2vR6IvSJem1ws4HpfAJ9ZqTKiXcogBGfTPaJR
 GI9QhVUieLkCDQRJEJm8EAgAzr9Zd3v7B10ODtVc7XxbMe3W6o1FdClL9ZIgLv61zhWctafK
 DMu/MUSvxmYFq00pecD/SfX8oxArA02+sQ2E+/Zb4J7NAWIAxCfmy7VE0wDBrZH/hBapIx/L
 gVqYfZ9Rw+a4FXrlk1y8oQCwhvj+kWrm7V7olR0aPOy1NFGNUyTFSMj+pbmxiNOXdCxVUQe3
 UE1k9yA+mILjyaRanwkiCLCjNvRPL88Q017BdhVBWZmz8qhwXN/RrjCcDHsPX5O0ev68MLyu
 sh5mfukuvCqzW1Y3Ql+iwfwEw5lNmQGdoV9csg7JP7saDicSFO2KcZvMbvDMqtPFipdF5UWo
 fZKZ3wADBQf/b5cVNyb5i8QI0G7BPGBNn4VlQX5n66TsPBnrRNOi3MhTTVEBCp8s+jqUjJjX
 EjjA+O4hIm7Qqdsozurw7GlcQ0A06dIzO/1RUglZZMoC0JL43ZQmJ+3+yFrLjWgGH6ev6AOb
 YLH7ZujgAB5n0Hy2ZIChzsKLKbHptFtBvpDKB8updq+GunsY4oN3wGa67h9sHqDvjyp64Czg
 n8G5uGLwx3f/edbECKz5kPUSzChEk3suK742SEP01v4ra5WX88Hn81NjGByQMz9acJLdC7Ff
 LzXvbNa0KgvDaSllYfsJIoGCz3eKVOuTWXOiaEIKuy833+3mr2PulLCyLKysAEddKohJBBgR
 AgAJBQJJEJm8AhsMAAoJELFYWyEf4koXhgQAn1EGATLZPS53At9t+p3S8BkNI9yRAJ9A0OmL
 liv+rwEesYGlGeGNaKHTJw==
Message-ID: <d4ae7a39-6c2b-4055-8a68-cd27f81ee3f3@suse.de>
Date:   Fri, 18 Jan 2019 17:46:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1547718344-27382-13-git-send-email-s1seetee@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/19 1:45 AM, Seeteena Thoufeek wrote:
> Support both Python 2 and Python 3 in stackcollapse.py. ``print`` is now a
> function rather than a statement. This should have no functional change.
> 
> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  tools/perf/scripts/python/stackcollapse.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/scripts/python/stackcollapse.py b/tools/perf/scripts/python/stackcollapse.py
> index 1697b5e..f77bc0d 100755
> --- a/tools/perf/scripts/python/stackcollapse.py
> +++ b/tools/perf/scripts/python/stackcollapse.py
> @@ -18,6 +18,7 @@
>  #
>  # Written by Paolo Bonzini <pbonzini@redhat.com>
>  # Based on Brendan Gregg's stackcollapse-perf.pl script.
> +from __future__ import print_function

Again, not necessary.
  
>  import os
>  import sys
> @@ -123,4 +124,4 @@ def trace_end():
>      list = lines.keys()
>      list.sort()
>      for stack in list:
> -        print "%s %d" % (stack, lines[stack])
> +        print("%s %d" % (stack, lines[stack]))
> 

Did you test any of these changes with Python3?

If you run 'ldd /usr/bin/perf | grep python' when you've built with PYTHON=python3,  what do you see?

$ ldd /usr/bin/perf | grep python
	libpython3.6m.so.1.0 => /usr/lib64/libpython3.6m.so.1.0 (0x00007fea66701000)

If you do,  you'll run into this error:

$ /usr/bin/perf script -s scripts/python/stackcollapse.py -i /tmp/perf.data
Traceback (most recent call last):
  File "scripts/python/stackcollapse.py", line 124, in trace_end
    list.sort()
AttributeError: 'dict_keys' object has no attribute 'sort'
Fatal Python error: problem in Python trace event handler

You need the following change in addition:

--- a/tools/perf/scripts/python/stackcollapse.py
+++ b/tools/perf/scripts/python/stackcollapse.py
@@ -120,7 +120,6 @@ def process_event(param_dict):
     lines[stack_string] = lines[stack_string] + 1

 def trace_end():
-    list = lines.keys()
-    list.sort()
+    list = sorted(lines)
     for stack in list:
-        print "%s %d" % (stack, lines[stack])
+        print ("%s %d" % (stack, lines[stack]))


As I said in a different post,  I'd not yet posted my series as I was still trying to fix the failure of the "import perf" testcase (aka tools/perf/python) and (apologies) I'd missed your V1 but maybe I should post them as they've been thoroughly integrated into perf and tested with python2 and python3.

The full patchset is in SLE15-SP1 beta2 which I know IBM has access to.  A backport is also in Factory.

Tony



