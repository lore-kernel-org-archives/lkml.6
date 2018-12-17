Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E37C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7F72086C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545068552;
	bh=1zscU9RRFiL1ApbVzkqjIC/CvPaKOVsGVmPqH+mNUyM=;
	h=To:Cc:From:Subject:Date:List-ID:From;
	b=b2oaxcYSLSYAN/AgwE+iHD9rasNW8tnEls83HLE8Y4REcZ+pu26LHQlAsNX0XGUmm
	 SNrs3LDGWYkEgWLucjQCTuCSGhW5/y97v1vEgtQX5TmNv28g04sHlyF8lSwn3yigFc
	 E5mdNSk3HQ0yjBLrxMzWQtOgLWr+cm3FSDjrzg1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388459AbeLQRma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:42:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:50566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbeLQRma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:42:30 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E685E20874;
        Mon, 17 Dec 2018 17:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545068549;
        bh=1zscU9RRFiL1ApbVzkqjIC/CvPaKOVsGVmPqH+mNUyM=;
        h=To:Cc:From:Subject:Date:From;
        b=R0uz7FVJCUvfJ1d042wII6O/JqeCaWTWIO6MZMjiSY5bmtGXwV7xaDeQ35rBSX/Nx
         jnjCVWjH0/jjpqDUIYJ55ZkqoEyrTzxnrrCbmQa5OFltjuGewb71Mc36R8xQqSKTaN
         D96JnXkalOJ2U+r1/yO5FoTocjQB6K6ezDYMPNx0=
To:     rafael@kernel.org
Cc:     Thomas Renninger <trenn@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, shuah <shuah@kernel.org>
From:   shuah <shuah@kernel.org>
Subject: [GIT PULL] cpupower update for Linux 4.21-rc1
Message-ID: <d8d3438a-04a3-2c64-ea04-92a888e59db4@kernel.org>
Date:   Mon, 17 Dec 2018 10:42:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------2335C19CE21BB8C5A2DC4353"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2335C19CE21BB8C5A2DC4353
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower update for Linux 4.21-rc1.

This cpupower update Linux 4.21 adds support for auto-completion for
cpupower tool from Abhishek Goel.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 2595646791c319cadfdbf271563aac97d0843dc7:

   Linux 4.20-rc5 (2018-12-02 15:07:55 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux 
tags/linux-cpupower-4.21-rc1

for you to fetch changes up to 901d32bc69f3423ad53947b992f973123faf2622:

   cpupower : Auto-completion for cpupower tool (2018-12-05 07:52:45 -0700)

----------------------------------------------------------------
linux-cpupower-4.21-rc1

This cpupower update Linux 4.21 adds support for auto-completion for
cpupower tool from Abhishek Goel.

----------------------------------------------------------------
Abhishek Goel (1):
       cpupower : Auto-completion for cpupower tool

  tools/power/cpupower/Makefile               |   6 +-
  tools/power/cpupower/cpupower-completion.sh | 128 
++++++++++++++++++++++++++++
  2 files changed, 133 insertions(+), 1 deletion(-)
  create mode 100644 tools/power/cpupower/cpupower-completion.sh

----------------------------------------------------------------

--------------2335C19CE21BB8C5A2DC4353
Content-Type: text/x-patch;
 name="linux-cpupower-4.21-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-cpupower-4.21-rc1.diff"

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index db66a952c173..fd8765af19bb 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -89,6 +89,7 @@ endif
 localedir ?=	/usr/share/locale
 docdir ?=       /usr/share/doc/packages/cpupower
 confdir ?=      /etc/
+bash_completion_dir ?= /usr/share/bash-completion/completions
 
 # Toolchain: what tools do we use, and what options do they need:
 
@@ -96,7 +97,8 @@ CP = cp -fpR
 INSTALL = /usr/bin/install -c
 INSTALL_PROGRAM = ${INSTALL}
 INSTALL_DATA  = ${INSTALL} -m 644
-INSTALL_SCRIPT = ${INSTALL_PROGRAM}
+#bash completion scripts get sourced and so they should be rw only.
+INSTALL_SCRIPT = ${INSTALL} -m 644
 
 # If you are running a cross compiler, you may want to set this
 # to something more interesting, like "arm-linux-".  If you want
@@ -288,6 +290,8 @@ install-lib:
 install-tools:
 	$(INSTALL) -d $(DESTDIR)${bindir}
 	$(INSTALL_PROGRAM) $(OUTPUT)cpupower $(DESTDIR)${bindir}
+	$(INSTALL) -d $(DESTDIR)${bash_completion_dir}
+	$(INSTALL_SCRIPT) cpupower-completion.sh '$(DESTDIR)${bash_completion_dir}/cpupower'
 
 install-man:
 	$(INSTALL_DATA) -D man/cpupower.1 $(DESTDIR)${mandir}/man1/cpupower.1
diff --git a/tools/power/cpupower/cpupower-completion.sh b/tools/power/cpupower/cpupower-completion.sh
new file mode 100644
index 000000000000..e10839cfcfc1
--- /dev/null
+++ b/tools/power/cpupower/cpupower-completion.sh
@@ -0,0 +1,128 @@
+# -*- shell-script -*-
+# bash completion script for cpupower
+# Taken from git.git's completion script.
+
+_cpupower_commands="frequency-info frequency-set idle-info idle-set set info monitor"
+
+_frequency_info ()
+{
+	local flags="-f -w -l -d -p -g -a -s -y -o -m -n --freq --hwfreq --hwlimits --driver --policy --governors --related-cpus --affected-cpus --stats --latency --proc --human --no-rounding"
+	local prev="${COMP_WORDS[COMP_CWORD-1]}"
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$prev" in
+		frequency-info) COMPREPLY=($(compgen -W "$flags" -- "$cur")) ;;
+	esac
+}
+
+_frequency_set ()
+{
+	local flags="-f -g --freq --governor -d --min -u --max -r --related"
+	local prev="${COMP_WORDS[COMP_CWORD-1]}"
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$prev" in
+		-f| --freq | -d | --min | -u | --max)
+		if [ -d /sys/devices/system/cpu/cpufreq/ ] ; then
+			COMPREPLY=($(compgen -W '$(cat $(ls -d /sys/devices/system/cpu/cpufreq/policy* | head -1)/scaling_available_frequencies)' -- "$cur"))
+		fi ;;
+		-g| --governor)
+		if [ -d /sys/devices/system/cpu/cpufreq/ ] ; then
+			COMPREPLY=($(compgen -W '$(cat $(ls -d /sys/devices/system/cpu/cpufreq/policy* | head -1)/scaling_available_governors)' -- "$cur"))
+		fi;;
+		frequency-set) COMPREPLY=($(compgen -W "$flags" -- "$cur")) ;;
+	esac
+}
+
+_idle_info()
+{
+	local flags="-f --silent"
+	local prev="${COMP_WORDS[COMP_CWORD-1]}"
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$prev" in
+		idle-info) COMPREPLY=($(compgen -W "$flags" -- "$cur")) ;;
+	esac
+}
+
+_idle_set()
+{
+	local flags="-d --disable -e --enable -D --disable-by-latency -E --enable-all"
+	local prev="${COMP_WORDS[COMP_CWORD-1]}"
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$prev" in
+		idle-set) COMPREPLY=($(compgen -W "$flags" -- "$cur")) ;;
+	esac
+}
+
+_set()
+{
+	local flags="--perf-bias, -b"
+	local prev="${COMP_WORDS[COMP_CWORD-1]}"
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$prev" in
+		set) COMPREPLY=($(compgen -W "$flags" -- "$cur")) ;;
+	esac
+}
+
+_monitor()
+{
+	local flags="-l -m -i -c -v"
+	local prev="${COMP_WORDS[COMP_CWORD-1]}"
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$prev" in
+		monitor) COMPREPLY=($(compgen -W "$flags" -- "$cur")) ;;
+	esac
+}
+
+_taskset()
+{
+	local prev_to_prev="${COMP_WORDS[COMP_CWORD-2]}"
+	local prev="${COMP_WORDS[COMP_CWORD-1]}"
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$prev_to_prev" in
+		-c|--cpu) COMPREPLY=($(compgen -W "$_cpupower_commands" -- "$cur")) ;;
+	esac
+	case "$prev" in
+		frequency-info) _frequency_info ;;
+		frequency-set) _frequency_set ;;
+		idle-info) _idle_info ;;
+		idle-set) _idle_set ;;
+		set) _set ;;
+		monitor) _monitor ;;
+	esac
+
+}
+
+_cpupower ()
+{
+	local i
+	local c=1
+	local command
+
+	while test $c -lt $COMP_CWORD; do
+		if test $c == 1; then
+			command="${COMP_WORDS[c]}"
+		fi
+		c=$((++c))
+	done
+
+	# Complete name of subcommand if the user has not finished typing it yet.
+	if test $c -eq $COMP_CWORD -a -z "$command"; then
+		COMPREPLY=($(compgen -W "help -v --version -c --cpu $_cpupower_commands" -- "${COMP_WORDS[COMP_CWORD]}"))
+		return
+	fi
+
+	# Complete arguments to subcommands.
+	case "$command" in
+		-v|--version) return ;;
+		-c|--cpu) _taskset ;;
+		help) COMPREPLY=($(compgen -W "$_cpupower_commands" -- "${COMP_WORDS[COMP_CWORD]}")) ;;
+		frequency-info) _frequency_info ;;
+		frequency-set) _frequency_set ;;
+		idle-info) _idle_info ;;
+		idle-set) _idle_set ;;
+		set) _set ;;
+		monitor) _monitor ;;
+	esac
+}
+
+complete -o bashdefault -o default -F _cpupower cpupower 2>/dev/null \
+    || complete -o default -F _cpupower cpupower

--------------2335C19CE21BB8C5A2DC4353--
