Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227nkTJV/NxhgodDKh/LH1S8gHgftilR1w+KEbQNXT4mIoeUVLYGgTvAnlR/RE1z808NA3A9
ARC-Seal: i=1; a=rsa-sha256; t=1518708401; cv=none;
        d=google.com; s=arc-20160816;
        b=qe/2Sz0vVTjyIQ3N6RNbiuR7Kq7YazaUzp3lrxtFqTE1XfCzZUKg5EqLmJpuMiOS8p
         5+rSARjCC4vS0Xz0cfeqzfO/5SBFedrjivTuzqZQEjtALyMON4jFzBD9A+hptEbKnVra
         zFVWpp55dWl7XDTeIC3rNFdz+lr/RSaMsFirw57femPPlD3n+x3YFihg6RILtdR9DAQ3
         0VOriLX+657M/gUuOUAI+I3Q/KtrUaQYlGvcK8RbAfPISF4NX9cwBRYrjXL/MuH/vRuu
         ocr8RFUervSRi001jEhQZJ6zdgnaV0hcptBYqP8n1Vc/iAoIsjKaAUD884GwY+zgwJjl
         NpDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=b5O11bJjs8rXY7/RVdJ1EL94PD82kkGYcODKM2BFsPA=;
        b=pAJWw6M5jPXS4g5+hnsY5aPHczN7qgHwarIKZ876PVmHqtehAL41HY7Bi975MnoBQS
         CNSUACsPTdx7AaLgA7dK/ITWk6a2FuC55BnlY699X9vrFFWThJF7BMluTltx+bMXvlBd
         V0GbLhaWVJGYl0iF7k6qgD9cjrY0/aAw1EYuatFNwnS8FKvo3Plgd1Q5cEwGj00M6ZIN
         +S9rn1p4vnHXet+n2Q6SxyO0DdWpttkNyyhJ93A4QS/xnU5xoVuDITf5Rb2oVfzx7ysI
         SfGWMkgzyWW/aK5/+bv4GGyKdTadPMix0wfp1nl1IOPVwnSX/oGpMB50YLhEDDS0izJ0
         bJbw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.9 30/88] ahci: Add Intel Cannon Lake PCH-H PCI ID
Date: Thu, 15 Feb 2018 16:16:57 +0100
Message-Id: <20180215151226.840424192@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480990674173939?=
X-GMAIL-MSGID: =?utf-8?q?1592481180692996741?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit f919dde0772a894c693a1eeabc77df69d6a9b937 upstream.

Add Intel Cannon Lake PCH-H PCI ID to the list of supported controllers.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/ahci.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -383,6 +383,7 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(INTEL, 0xa206), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa252), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa256), board_ahci }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0xa356), board_ahci }, /* Cannon Lake PCH-H RAID */
 	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci }, /* Bay Trail AHCI */
 	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci }, /* Bay Trail AHCI */
 	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci }, /* Cherry Trail AHCI */
