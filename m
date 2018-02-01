Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AH8x226sCGnrJ2XdcPu6LyDgsnoDKUEH99PVkSoUodlZyUa2ibT+Pbcd2rCt8+ZqIOko6eSoDuzh
ARC-Seal: i=1; a=rsa-sha256; t=1517503742; cv=none;
        d=google.com; s=arc-20160816;
        b=vWvy15JHbaVBC+Hih6DhewMbMmhtm8dvKXEkZKCS5tqlYMFFOtqA3lvDEM7mN8DiJF
         /PFIGZTccHwxnVszMRO9QD4tAo7DOEXXgo4/vWvu7d2+hRZHXIbYbJbZdjjFXYtA9j+e
         dh3bXfUiwcAgRSBavtkMqROT7dhKUoi3BqOdj9/Pj+cSsw/JIWbbCK6+7m376YmigUmZ
         R4V2Zr6zOmdAfUdcwV0yQsUZjEuJW1/aXTWaWGDwRdsgesVW3dzx5OCgHtIGdIGkF8bW
         QbE1dJ/edvW0VMdzNIQEeXRDlfT+dxgL97sO2xXNCt423bsC4su0YIffVnN9gAXwjAwT
         B65w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=wS+dyZNPY9ZvrLgzODw68dqD9TH4sNbmLTpl1LqP8jE=;
        b=m/h1eCxr8DItEvVs0Yhf1ur0u1QLN55LIGjdzmpF2FgddSZ2oht+IwEsxF24ORLw3l
         rKAE7a6CsvEzPj+Jm6m8wSdyvcMlQqNnOeacJOKBPH5eQtzuisStdUfzfoj0gfO/djoK
         7pkwjwQBZEYiJwESHJxsAMMuB9saY6ohs6jNcfrEDhg32BZqm6ZgygSwaVWsrroweceR
         jZ1yWS53EALj+43z0VQ4b53ye2zxlXA/D7RYH83q48/IexwRQigP074wathTmzmO0n6R
         ckPvp52FOMIkFg6B/5Enmk3JmmPXux2xAGnp08PVJSMSwuXJ9h6aMaW74MSNYeXcPyn8
         0Yiw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.232 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.232 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Cc: linux-scsi@vger.kernel.org,  linux-kernel@vger.kernel.org,  gregkh@linuxfoundation.org,  jaegeuk@kernel.org,  alex.lemberg@wdc.com
References: <1517501746-19075-1-git-send-email-stanislav.nijnikov@wdc.com>
Date: Thu, 01 Feb 2018 10:48:53 -0600
In-Reply-To: <1517501746-19075-1-git-send-email-stanislav.nijnikov@wdc.com>
	(Stanislav Nijnikov's message of "Thu, 1 Feb 2018 18:15:36 +0200")
Message-ID: <87y3kck64q.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ehI2m-0002zI-Gx;;;mid=<87y3kck64q.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Ng7xWuaTRLk3DJ8sdRFYBnzgNpr261II=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.0 TVD_RCVD_IP Message was received from an IP address
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 296 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 3.9 (1.3%), b_tie_ro: 2.9 (1.0%), parse: 1.05 (0.4%),
	extract_message_metadata: 10 (3.2%), get_uri_detail_list: 1.83 (0.6%),
	tests_pri_-1000: 3.9 (1.3%), tests_pri_-950: 1.04 (0.4%), tests_pri_-900:
	0.90 (0.3%), tests_pri_-400: 23 (7.6%), check_bayes: 22 (7.3%), b_tokenize: 6
	(2.0%), b_tok_get_all: 8 (2.8%), b_comp_prob: 1.79 (0.6%), b_tok_touch_all:
	3.5 (1.2%), b_finish: 0.79 (0.3%), tests_pri_0: 211 (71.0%),
	check_dkim_signature: 0.42 (0.1%), check_dkim_adsp: 2.8 (0.9%),
	tests_pri_500: 40 (13.5%), poll_dns_idle: 32 (10.7%), rewrite_mail: 0.00
	(0.0%)
Subject: Re: [PATCH v4 00/10] ufs: sysfs: read-only access to device descriptors, attributes and flags
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591215916113851463?=
X-GMAIL-MSGID: =?utf-8?q?1591218004020430685?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Can you please clarify the naming, at least as far as saying scsi/ufs.

Universal Flash Storage is not the same thing as all as the Unix File
System which has been using the acronym ufs for much longer.

I saw this patchset and I was wondering what in the world does a
filesystem need with sysfs entries.

Eric


Stanislav Nijnikov <stanislav.nijnikov@wdc.com> writes:

> This patch introduces sysfs entries that will provide read-only access to
> device management data that could be received with UFS query requests.
> User-space applications will be able to read UFS device descriptors,
> flags and attributes. This will allow to get full UFS device configuration
> and its status. The descriptors are provided as set of files representing
> its parameters. The flags are using "true"/"false" representation of
> their value. The attributes are shown as hexadecimal value. The
> descriptors, attributes and flags are placed in separate subfolders under
> the UFS device sysfs entry (/sys/bus/platform/drivers/ufshcd/*/). The
> string descriptor subfolder contains five string descriptors defined by
> UFS specification 2.1. The LUN specific descriptor and attribute are 
> placed under corresponding SCSI device sysfs entries
> (/sys/class/scsi_device/*/device/).
> In addition the patch presents an additional field in the
> scsi_host_template structure - struct attribute_group **sdev_group.
> This field allows to define groups of attributes. It will provide an
> ability to use binary attributes in addition to device attributes and
> to group them under subfolders if necessary.
>
> Changelog:
> v3 -> v4
> Additional patch the introduces default attributes group for the
> existing ufs sysfs entries (rpm_lvl and spm_lvl)
> The ufs_sysfs_read_desc_param function calls to ufshcd_read_desc_param
> insted of ufshcd_query_descriptor_retry to avoid code duplication.
> The code was updated to remove the checkpatch error "ERROR: Macros 
> with complex values should be enclosed in parentheses"
> Added "_" to macros parameters to remove "#undef DEVICE_CLASS"
> The legal information was updated to satisfy the SPDX requirements
> The date in Documentation/ABI/testing/sysfs-driver-ufs was updated.
>
> v2 -> v3
> The Makefile is updated to make ufs-sysfs.c part of the ufshcd module.
> The unnecessary EXPORT_SYMBOL were removed
> Added a legal info header to the new files
> The date in Documentation/ABI/testing/sysfs-driver-ufs was updated.
>
> v1 -> v2
> Provided additional description for the changes
>
> Stanislav Nijnikov (10):
>   ufs: sysfs: attribute group for existing sysfs entries.
>   ufs: sysfs: device descriptor
>   ufs: sysfs: interconnect descriptor
>   ufs: sysfs: geometry descriptor
>   ufs: sysfs: health descriptor
>   ufs: sysfs: power descriptor
>   ufs: sysfs: string descriptors
>   ufs: sysfs: unit descriptor
>   ufs: sysfs: flags
>   ufs: sysfs: attributes
>
>  Documentation/ABI/testing/sysfs-driver-ufs | 804 +++++++++++++++++++++++++++++
>  drivers/scsi/scsi_sysfs.c                  |  14 +
>  drivers/scsi/ufs/Makefile                  |   3 +-
>  drivers/scsi/ufs/ufs-sysfs.c               | 757 +++++++++++++++++++++++++++
>  drivers/scsi/ufs/ufs-sysfs.h               |  25 +
>  drivers/scsi/ufs/ufs.h                     | 115 ++++-
>  drivers/scsi/ufs/ufshcd.c                  | 218 ++------
>  drivers/scsi/ufs/ufshcd.h                  |  34 ++
>  include/scsi/scsi_host.h                   |   6 +
>  9 files changed, 1785 insertions(+), 191 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-ufs
>  create mode 100644 drivers/scsi/ufs/ufs-sysfs.c
>  create mode 100644 drivers/scsi/ufs/ufs-sysfs.h
