Return-Path: <arushisinghal19971997@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520161081; cv=none;
        d=google.com; s=arc-20160816;
        b=FJHfzbFmGjr6cJLobXjRj/0tZTpTLadIYfcyB5UpSsOeYnsYuk4UfCwqxbCndEiwXN
         KbO0JYGtaGg4xNLUnSPLne1kuqsi7fh2jEdFJheH5yCXmyaXD47o4vjsnSC1G7nqtvfv
         TE0/Bv2rci4EResWRj5haUKEZQJQJoIV+l2vkvk00SUY1eWK9CFHUngrE7lJaM2uaP/B
         B/pup2TitAYKaRRrtX8sW0r3jphcvlF0Gfj1RlhU9nX1N/3Sry8ZrKkLeWJWi2+1FfwF
         K3iR52/GAbDj9AZtIoZxWOQLvJR+2OqHd2o2Trgqqe0LjVkO+ofPrzXo7x5LGE6FzGxG
         cFxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=uBBNHzhGgyThHf4Nl1Y97KmFeNYDtMq9t4QQSXY68fE=;
        b=FfsrKd943dBIkGifQo/ZPxB96gdOP/JebyiMptEdlbNkgtjMT0K4QKKGoPd8CTQyAr
         2n9OCz57uWZKxmWlbMaMe7+PVpj+5jqDgMDA1FXrlIZzcSv0LYlA6E0lXR0kH51geaSE
         V+aLLucvEXZO1aNxONF3sHokzwJn1VbQYrmcoieMiE3Iq1VvxMOIsjWH7+WuVSabslkT
         QyET+cfYcjwrLV7Qe4hWsz/FAyAPC/B4KgkkyiUyIjlqLhIdomqJfxRvh0FProh+J/ER
         fqwVbf40eFjJrhsePwLtgJAZhd/1kGCfDbFqBgH0CFJq2LI5Pae6TFWgqA2eCG8vWCWc
         rqHw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TKMYqMf/;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TKMYqMf/;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvXA/CD7SnoCiMR9GahY+4DmHy23UgKyVXJ9IoagwOu1ef25hhGCTkrU8OFhWb77osMm3hjqg==
Date: Sun, 4 Mar 2018 16:27:33 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: abbotti@mev.co.uk
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	outreachy-kernel@googlegroups.com
Subject: [PATCH] staging: comedi: "dont" is changed to "don't"
Message-ID: <20180304105732.GA24762@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594004426152226048?=
X-GMAIL-MSGID: =?utf-8?q?1594004426152226048?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

"dont" is changed to "don't" in messages, "dont" is not correct
english.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/staging/comedi/drivers/cb_pcidas64.c | 2 +-
 drivers/staging/comedi/drivers/das16.c       | 2 +-
 drivers/staging/comedi/drivers/das16m1.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/comedi/drivers/cb_pcidas64.c b/drivers/staging/comedi/drivers/cb_pcidas64.c
index c007500..ceef905 100644
--- a/drivers/staging/comedi/drivers/cb_pcidas64.c
+++ b/drivers/staging/comedi/drivers/cb_pcidas64.c
@@ -1700,7 +1700,7 @@ static void i2c_write(struct comedi_device *dev, unsigned int address,
 	 * eeprom and i2c bus
 	 */
 
-	/* make sure we dont send anything to eeprom */
+	/* make sure we don't send anything to eeprom */
 	devpriv->plx_control_bits &= ~PLX_CNTRL_EECS;
 
 	i2c_stop(dev);
diff --git a/drivers/staging/comedi/drivers/das16.c b/drivers/staging/comedi/drivers/das16.c
index 74ff204..81eb51b 100644
--- a/drivers/staging/comedi/drivers/das16.c
+++ b/drivers/staging/comedi/drivers/das16.c
@@ -619,7 +619,7 @@ static int das16_cmd_test(struct comedi_device *dev, struct comedi_subdevice *s,
 
 	/* Step 2b : and mutually compatible */
 
-	/*  make sure scan_begin_src and convert_src dont conflict */
+	/*  make sure scan_begin_src and convert_src don't conflict */
 	if (cmd->scan_begin_src == TRIG_FOLLOW && cmd->convert_src == TRIG_NOW)
 		err |= -EINVAL;
 	if (cmd->scan_begin_src != TRIG_FOLLOW && cmd->convert_src != TRIG_NOW)
diff --git a/drivers/staging/comedi/drivers/das16m1.c b/drivers/staging/comedi/drivers/das16m1.c
index 72f8ed2..4e36377 100644
--- a/drivers/staging/comedi/drivers/das16m1.c
+++ b/drivers/staging/comedi/drivers/das16m1.c
@@ -407,7 +407,7 @@ static void das16m1_handler(struct comedi_device *dev, unsigned int status)
 		if (num_samples > cmd->stop_arg * cmd->chanlist_len)
 			num_samples = cmd->stop_arg * cmd->chanlist_len;
 	}
-	/*  make sure we dont try to get too many points if fifo has overrun */
+	/*  make sure we don't try to get too many points if fifo has overrun */
 	if (num_samples > DAS16M1_AI_FIFO_SZ)
 		num_samples = DAS16M1_AI_FIFO_SZ;
 	insw(dev->iobase, devpriv->ai_buffer, num_samples);
-- 
2.7.4
