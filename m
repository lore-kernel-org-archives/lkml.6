Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490082-1521483757-2-5027589530136098731
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521483756; b=cNHysjaMekjLw2+YKbtjTyrR2C4rVzN3I/ugkUiFkdsDdPa
    w7nNPFA7YqOu5gQXpgKN7SgaDmjhbDQglpT07LqkFYKDjHcj/UWj1m/2BBu2fBSa
    2jjaPjm2c0Ue2/9vub6VXRakBnIXlRpUwu5bqjOMpih6py1ZSH84ZAP8bTt7qoaN
    hcIHSppafji8QXeSFMuHFf4oEhDDTo2eIN9Ye4gnpbbsPDH/JdSBdLUMXp8vDlH6
    RwFCQsrbnJRlrLM/9tPbkd+WLLn7T1Z+h0G+xwB06lFzejxUx1DEJALWf4VY9yOp
    HeH3f9Bf9ZBpKgs2YTPzkZZBhEdYBaktRNPtkMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521483756; bh=avTj2zxHAuG7zEKgfMr4BUnR/N
    AZDcz3fv8F6nAiFbc=; b=U4CJFZV6zVXDeU1YJ2LuHJbKbkRMDPv4QA9swXmfag
    FTM/jSTGwRvghcsT7lDBMH8XI8dX/WLFPG/fcc5gpg42RiykuSn+S7tULNsx2g2C
    9JqlaVcQNrMBwQc78UVWQ+DVC6Omc8GZX0mjIvzXYjpkTGNZ7y2UqYRZLNJMUNGW
    lyQvl+eflkr2rlq1ntExPwNQ9vprPOJ4b+X+jROIfracl8Ux7lUqDgbYF4tbIzrJ
    kvBmVQFGIG4XXEtnXb87uHCG5Ss9ZTGKCj+lIgfc/B5Jr++Oi5ZEnsND19I6eG+G
    zLtxUbWuLNECBbiFQS3n+6wKrd3murdz30+3TH7ko7Iw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduuddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepgedutddvnecuvehluhhsthgvrhfuihiivgepud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduuddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepgedutddvnecuvehluhhsthgvrhfuihiivgepud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031294AbeCSSWe (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:22:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48548 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031285AbeCSSWa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:22:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 068/241] perf annotate: Fix a bug following symbolic link of a build-id file
Date: Mon, 19 Mar 2018 19:05:33 +0100
Message-Id: <20180319180754.020953503@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Taeung Song <treeze.taeung@gmail.com>


[ Upstream commit 6ebd2547dd24daf95a21b2bc59931de8502afcc3 ]

It is wrong way to read link name from a build-id file.  Because a
build-id file is not anymore a symbolic link but build-id directory of
it is symbolic link, so fix it.

For example, if build-id file name gotten from
dso__build_id_filename() is as below,

  /root/.debug/.build-id/4f/75c7d197c951659d1c1b8b5fd49bcdf8f3f8b1/elf

To correctly read link name of build-id, use the build-id dir path that
is a symbolic link, instead of the above build-id file name like below.

  /root/.debug/.build-id/4f/75c7d197c951659d1c1b8b5fd49bcdf8f3f8b1

Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1490598638-13947-2-git-send-email-treeze.taeung@gmail.com
Fixes: 01412261d994 ("perf buildid-cache: Use path/to/bin/buildid/elf instead of path/to/bin/buildid")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/annotate.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1250,6 +1250,7 @@ static int dso__disassemble_filename(str
 {
 	char linkname[PATH_MAX];
 	char *build_id_filename;
+	char *build_id_path = NULL;
 
 	if (dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS &&
 	    !dso__is_kcore(dso))
@@ -1265,8 +1266,14 @@ static int dso__disassemble_filename(str
 		goto fallback;
 	}
 
+	build_id_path = strdup(filename);
+	if (!build_id_path)
+		return -1;
+
+	dirname(build_id_path);
+
 	if (dso__is_kcore(dso) ||
-	    readlink(filename, linkname, sizeof(linkname)) < 0 ||
+	    readlink(build_id_path, linkname, sizeof(linkname)) < 0 ||
 	    strstr(linkname, DSO__NAME_KALLSYMS) ||
 	    access(filename, R_OK)) {
 fallback:
@@ -1278,6 +1285,7 @@ fallback:
 		__symbol__join_symfs(filename, filename_size, dso->long_name);
 	}
 
+	free(build_id_path);
 	return 0;
 }
 
