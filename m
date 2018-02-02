Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AH8x226DgFtgd8r7PJtryrLskkuKRni3zMREbP1aefMxf3Ym9Dueoa/XN/chu/C9zaG+4LtV9HSw
ARC-Seal: i=1; a=rsa-sha256; t=1517538583; cv=none;
        d=google.com; s=arc-20160816;
        b=sBOYlksZxpAp+mt3TSeMZu2JmlWHQ+v3DHM1LyRINy075H3AWp9TMBUJH+UernFP3u
         NAi3OucAZ3fqzzfuPpsvie7fhIAfZvJswZShwJCoYhgNT0JcduFtGk9yow20426HSFtl
         tyKzTYk2805h0kd+7SGRI3iuOuumBWSpJ1aBGO5xVlhF8TDpiaHQO6trEd4RkQcqDBzk
         o71XDqUSHIA/ZFhpn22cbAYx2JVvA9K3hdR5ox57oDhSrI/KA+3S55dx5W/H5i5pK4Z+
         QxWwgj7+pMp2Kb0qwXKglSB5RircZyyz4E7E6/bB2kbkCgAPQkA/Le1QaTR1auj/z44P
         i2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=b21+JdIN1HW70C8sHWaUAyc8UWcxuj5sFVc5ybk+v2s=;
        b=OqS50jIdlOW2gsDMQfA2vqYndTmP7hXmrhotjAMajp1RN8rGufVSFPV7+2p2aVYqxp
         MXg7w2COz+U0EH23gWmcL+bomY+elRL5RnDc847scegDKYhEPEVK/W+vsAfPx1jkLNEF
         ffMifcgZRjfdhx5m1rvXLRBVtiHeHhPBrzGLE0ZzF2OtHY6J1i0DO8PN6/Hi4HEKaYDg
         XiGoFUAKx5N5Cbz8VYpirraBY+xfdulSIIK5CfZl4xOM2ywWso4HUb1DQpmEqKrMNFP0
         efQxY8F6CopgY/RKcXzb7rR1HFbTuZ1jtdV+hFaJwFUxLjIwSe5A5a+1kDyZ2yKnmqVR
         lz4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.233 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.233 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: davem@davemloft.net,  dave.hansen@linux.intel.com,  aarcange@redhat.com,  akpm@linux-foundation.org,  allen.pais@oracle.com,  anthony.yznaga@oracle.com,  arnd@arndb.de,  babu.moger@oracle.com,  benh@kernel.crashing.org,  bob.picco@oracle.com,  bsingharora@gmail.com,  corbet@lwn.net,  dan.j.williams@intel.com,  dave.jiang@intel.com,  david.j.aldridge@oracle.com,  elena.reshetova@intel.com,  glx@linutronix.de,  gregkh@linuxfoundation.org,  hannes@cmpxchg.org,  hillf.zj@alibaba-inc.com,  hpa@zytor.com,  hughd@google.com,  imbrenda@linux.vnet.ibm.com,  jack@suse.cz,  jag.raman@oracle.com,  jane.chu@oracle.com,  jglisse@redhat.com,  jroedel@suse.de,  khalid@gonehiking.org,  khandual@linux.vnet.ibm.com,  kirill.shutemov@linux.intel.com,  kstewart@linuxfoundation.org,  ktkhai@virtuozzo.com,  liam.merwick@oracle.com,  linux-arch@vger.kernel.org,  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  linuxppc-dev@lists.ozlabs.org,  linux@roeck-us.net,  me@tobin.cc,  mgorman@suse.de,  mgorman@techsingularity.net,  mhocko@suse.com,  mike.kravetz@oracle.com,  minchan@kernel.org,  mingo@kernel.org,  mingo@redhat.com,  mpe@ellerman.id.au,  nadav.amit@gmail.com,  nagarathnam.muthusamy@oracle.com,  nborisov@suse.com,  n-horiguchi@ah.jp.nec.com,  nick.alcock@oracle.com,  nitin.m.gupta@oracle.com,  ombredanne@nexb.com,  pasha.tatashin@oracle.com,  paulus@samba.org,  pombredanne@nexb.com,  punit.agrawal@arm.com,  rob.gardner@oracle.com,  ross.zwisler@linux.intel.com,  shannon.nelson@oracle.com,  shli@fb.com,  sparclinux@vger.kernel.org,  steven.sistare@oracle.com,  tglx@linutronix.de,  thomas.tai@oracle.com,  tklauser@distanz.ch,  tom.hromatka@oracle.com,  vegard.nossum@oracle.com,  vijay.ac.kumar@oracle.com,  willy@infradead.org,  x86@kernel.org,  zi.yan@cs.rutgers.edu
References: <cover.1517497017.git.khalid.aziz@oracle.com>
Date: Thu, 01 Feb 2018 20:29:14 -0600
In-Reply-To: <cover.1517497017.git.khalid.aziz@oracle.com> (Khalid Aziz's
	message of "Thu, 1 Feb 2018 11:01:08 -0700")
Message-ID: <87wozwi0p1.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ehR6U-0006ic-9j;;;mid=<87wozwi0p1.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+cM0WqtYpE41EPEcZ78n90fSTaGFfY42M=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.0 TVD_RCVD_IP Message was received from an IP address
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Khalid Aziz <khalid.aziz@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1367 ms - load_scoreonly_sql: 0.06 (0.0%),
	signal_user_changed: 3.3 (0.2%), b_tie_ro: 2.3 (0.2%), parse: 1.35 (0.1%),
	extract_message_metadata: 16 (1.2%), get_uri_detail_list: 1.50 (0.1%),
	tests_pri_-1000: 9 (0.7%), tests_pri_-950: 1.81 (0.1%), tests_pri_-900: 1.60
	(0.1%), tests_pri_-400: 36 (2.6%), check_bayes: 34 (2.5%), b_tokenize: 14
	(1.0%), b_tok_get_all: 10 (0.7%), b_comp_prob: 3.3 (0.2%), b_tok_touch_all:
	4.6 (0.3%), b_finish: 0.73 (0.1%), tests_pri_0: 1288 (94.2%),
	check_dkim_signature: 0.55 (0.0%), check_dkim_adsp: 3.1 (0.2%),
	tests_pri_500: 4.6 (0.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v11 00/10] Application Data Integrity feature introduced by SPARC M7
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591223715312130121?=
X-GMAIL-MSGID: =?utf-8?q?1591254537993505613?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Khalid Aziz <khalid.aziz@oracle.com> writes:

> V11 changes:
> This series is same as v10 and was simply rebased on 4.15 kernel. Can
> mm maintainers please review patches 2, 7, 8 and 9 which are arch
> independent, and include/linux/mm.h and mm/ksm.c changes in patch 10
> and ack these if everything looks good?

I am a bit puzzled how this differs from the pkey's that other
architectures are implementing to achieve a similar result.

I am a bit mystified why you don't store the tag in a vma
instead of inventing a new way to store data on page out.

Can you please use force_sig_fault to send these signals instead
of force_sig_info.  Emperically I have found that it is very
error prone to generate siginfo's by hand, especially on code
paths where several different si_codes may apply.  So it helps
to go through a helper function to ensure the fiddly bits are
all correct.  AKA the unused bits all need to be set to zero before
struct siginfo is copied to userspace.

Eric
