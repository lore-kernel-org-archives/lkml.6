Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224QnJORai/oQsE2Upuqu5PCuLzrP89f/ix220ZtnZxf6XdgC3ToomhdfXWkDhZVpsHCJmNH
ARC-Seal: i=1; a=rsa-sha256; t=1518709410; cv=none;
        d=google.com; s=arc-20160816;
        b=NhEXTllQwZ0iqCwcxlBepQPQg+vk3uNCpN5EGkF0Pg3kBTHCfUh2ja5fe1bvXBLPGL
         PLyCPNTSq7t2JuqamGYxl9xxeeLbSff+sjtu9vEc9tjn1ZzLobLjVhhngjI6P6E+2iw0
         L0BSU3WWyxRrHvfysUMVGjbqa3ejY6hxFJrrm1xse3K5m8ndsCr+WdnmQKwhec7azqw4
         lm9EjhR3xcG0QOcEYXabpRA9Zx8Ojk/V/Im7IFVCZkWSDm14RdWqsGoEXmL+AKc2B4Vo
         mKHs6E3LR0RsmEiOR5eT0zLbgK3sTyMWJfv3WSbp8PV6906XA6MH+Ej81kPxiBR63ioJ
         KaFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=W+RLaDRLsuuTlumULIa+nkryGwclkJZDpZD2MMfkjnA=;
        b=meQbPFYJ/JoE/bj3hWsCwS3sZDF6JshWPztzOjQN3CqDfcgKlBNK2vEIj1S7nUhkCk
         TA81iZRGKxgFmS84FmpztwGY8zjHMZAuMP23gWGKalW9MpRwfPdEqTTY0n1oVhbSOOUy
         ZiJ05Jft7rKzMQpIKtpGOJuvl1nzKUpQxGZ4kYdeXzEfnGJlH2f2UGG5zI2Ta9gzma9r
         RpQHBcXrg23W/c0kP/CpCJMZ97x0bB+SaWGTDonAAD8rcb1hcX8G+JyXCuPok4M0nvqW
         iQxj0flfPZP+RTxFyj9j4mMJpjNplwP2qMEPXeTXlC1BWWw6k0GXDjk/oY9q45VQWmgR
         y3Rg==
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
Subject: [PATCH 4.15 107/202] ahci: Add Intel Cannon Lake PCH-H PCI ID
Date: Thu, 15 Feb 2018 16:16:47 +0100
Message-Id: <20180215151718.849158975@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480990674173939?=
X-GMAIL-MSGID: =?utf-8?q?1592482238960280606?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -386,6 +386,7 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(INTEL, 0xa206), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa252), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa256), board_ahci }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0xa356), board_ahci }, /* Cannon Lake PCH-H RAID */
 	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci }, /* Bay Trail AHCI */
 	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci }, /* Bay Trail AHCI */
 	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci }, /* Cherry Trail AHCI */
