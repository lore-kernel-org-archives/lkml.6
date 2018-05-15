Return-Path: <mika.westerberg@linux.intel.com>
X-Google-Smtp-Source: AB8JxZo4v+tjcrJZUbCczy6uMJIcWkhhx4YVngtan6x/fG9TRgaoW92cE5iNiWgg8q+IxDD+/Xcv
ARC-Seal: i=1; a=rsa-sha256; t=1526389469; cv=none;
        d=google.com; s=arc-20160816;
        b=0EfjKgBmmgiatcE4guxl4Cqr4hX8SV4aHgSmm6uSsAm8RTshT53LrypBob4uIj39hU
         8S4bo9RJhVnUkCt4Z/WkIE0yJCEnbgio5QQDe2Sto/hhuWdUTe9LWPsFkks6J9Xb876i
         qaXgXsU8mCRj8ogU3VsR0IuIIr0nFEeUWIyDBCEB9JAGCHSxc+3NPoR2R3/Pw2QtD8Oh
         EcLVb6eDwO6YmvSEnkGHPokBkUFmZ0h4TtKcj9cpxGzdzmt5++gPGy3NE6Cyac6Eyybn
         Z1ibql0BHTOMORYoK+jDaUssce6V9mP/1/eZq4F7tyci1u8gbUbjqZqzzHMhwkc6ETNx
         8K6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=OQEt+7qlICWPwPrjFSuzMzZvjU39NxVzEWOcRHCxGzE=;
        b=h7sI08AfAKb4sZ78NYal6pvMru/wlwY1hMP02WZfHDtFvfokJdWdFcH2T74YumbL59
         DhfSF3We+6W5emEM6qy2S2xW5LQ8CDzvxM/crK/Ukw3CdSUSKW4lmaIBg2GUfgmwIlXP
         8iFM4ONeXvgks94MwDPDaGizhxUwRfedNjb71Ehyhgw8NlRf7b5gmxYdvBLkE4R9j+fp
         OIvGyOv2EBDbJHXOL8JeE6rUfuSWhwZHGvMWL+Tu/MufoeekbIiatWFo58pGtbgnXQvH
         lzFrJlj7jXvOfhB8QXZTWg/MNmVHacc+5lMYUGMlK7LSDB65pG2D4lecpbwDIxApajzG
         nHnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="39477096"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] thunderbolt: Fix for v4.17-rc6
Date: Tue, 15 May 2018 16:04:24 +0300
Message-Id: <20180515130425.7652-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600535365017048858?=
X-GMAIL-MSGID: =?utf-8?q?1600535365017048858?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

There is one fix to make preboot ACL handling show NULL entries correctly
in sysfs.

The patch is also included in case you want to apply it directly instead of
pulling the signed tag.

The following changes since commit 75bc37fefc4471e718ba8e651aa74673d4e0a9eb:

  Linux 4.17-rc4 (2018-05-06 16:57:38 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git tags/thunderbolt-fixes-for-v4.17-rc6

for you to fetch changes up to 50739cafb9401b9bf7642a5e1de88987b9d0c0fa:

  thunderbolt: Handle NULL boot ACL entries properly (2018-05-07 15:14:16 +0300)

Mika Westerberg (1):
  thunderbolt: Handle NULL boot ACL entries properly

 drivers/thunderbolt/icm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.17.0
