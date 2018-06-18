Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299EDC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C275E208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:41:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C275E208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934676AbeFRKlZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:41:25 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:53848 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934158AbeFRKlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:41:05 -0400
Received: from faui49man5 (faui49man5.informatik.uni-erlangen.de [131.188.42.193])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 867A358C53A;
        Mon, 18 Jun 2018 12:31:26 +0200 (CEST)
Received: by faui49man5 (sSMTP sendmail emulation); Mon, 18 Jun 2018 12:31:26 +0200
From:   Roman Sommer <roman.sommer@fau.de>
Cc:     Roman Sommer <roman.sommer@fau.de>, linux-kernel@i4.cs.fau.de,
        Daniel Graefe <daniel.graefe@fau.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        =?UTF-8?q?Hans=20P=2E=20M=C3=B6ller=20Ebner?= <hmoller@uc.cl>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Fabi=C3=A1n=20Inostroza?= <soulsonceonfire@gmail.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] sound/line6: checkpatch: fix block comment style
Date:   Mon, 18 Jun 2018 12:29:37 +0200
Message-Id: <1529317779-15908-2-git-send-email-roman.sommer@fau.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529317779-15908-1-git-send-email-roman.sommer@fau.de>
References: <1529317779-15908-1-git-send-email-roman.sommer@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.com>
CC: Takashi Sakamoto <o-takashi@sakamocchi.jp>
CC: "Hans P. Möller Ebner" <hmoller@uc.cl>
CC: Kees Cook <keescook@chromium.org>
CC: Kate Stewart <kstewart@linuxfoundation.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: "Fabián Inostroza" <soulsonceonfire@gmail.com>
CC: Bhumika Goyal <bhumirks@gmail.com>
CC: Philippe Ombredanne <pombredanne@nexb.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: alsa-devel@alsa-project.org
CC: linux-kernel@vger.kernel.org

This patch fixed the style of multiline comments in sound/usb/line6.

Signed-off-by: Roman Sommer <roman.sommer@fau.de>
Signed-off-by: Daniel Graefe <daniel.graefe@fau.de>
---
 sound/usb/line6/capture.c  |  20 ++++-----
 sound/usb/line6/driver.c   | 100 ++++++++++++++++++++++-----------------------
 sound/usb/line6/driver.h   |  24 +++++------
 sound/usb/line6/midi.c     |  24 +++++------
 sound/usb/line6/midibuf.c  |   6 +--
 sound/usb/line6/pcm.c      |  22 +++++-----
 sound/usb/line6/pcm.h      |  68 +++++++++++++++---------------
 sound/usb/line6/playback.c |  34 +++++++--------
 sound/usb/line6/pod.c      |  60 +++++++++++++--------------
 sound/usb/line6/podhd.c    |   8 ++--
 sound/usb/line6/toneport.c |  30 +++++++-------
 sound/usb/line6/variax.c   |  40 +++++++++---------
 12 files changed, 218 insertions(+), 218 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index 947d616..321605c 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -19,9 +19,9 @@
 #include "pcm.h"
 
 /*
-	Find a free URB and submit it.
-	must be called in line6pcm->in.lock context
-*/
+ * Find a free URB and submit it.
+ * must be called in line6pcm->in.lock context
+ */
 static int submit_audio_in_urb(struct snd_line6_pcm *line6pcm)
 {
 	int index;
@@ -66,9 +66,9 @@ static int submit_audio_in_urb(struct snd_line6_pcm *line6pcm)
 }
 
 /*
-	Submit all currently available capture URBs.
-	must be called in line6pcm->in.lock context
-*/
+ * Submit all currently available capture URBs.
+ * must be called in line6pcm->in.lock context
+ */
 int line6_submit_audio_in_all_urbs(struct snd_line6_pcm *line6pcm)
 {
 	int ret = 0, i;
@@ -83,8 +83,8 @@ int line6_submit_audio_in_all_urbs(struct snd_line6_pcm *line6pcm)
 }
 
 /*
-	Copy data into ALSA capture buffer.
-*/
+ * Copy data into ALSA capture buffer.
+ */
 void line6_capture_copy(struct snd_line6_pcm *line6pcm, char *fbuf, int fsize)
 {
 	struct snd_pcm_substream *substream =
@@ -100,8 +100,8 @@ void line6_capture_copy(struct snd_line6_pcm *line6pcm, char *fbuf, int fsize)
 
 	if (line6pcm->in.pos_done + frames > runtime->buffer_size) {
 		/*
-		   The transferred area goes over buffer boundary,
-		   copy two separate chunks.
+		 * The transferred area goes over buffer boundary,
+		 * copy two separate chunks.
 		 */
 		int len;
 
diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index c1376bf..df7e761 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -28,24 +28,24 @@
 #define DRIVER_DESC    "Line 6 USB Driver"
 
 /*
-	This is Line 6's MIDI manufacturer ID.
-*/
+ * This is Line 6's MIDI manufacturer ID.
+ */
 const unsigned char line6_midi_id[3] = {
 	0x00, 0x01, 0x0c
 };
 EXPORT_SYMBOL_GPL(line6_midi_id);
 
 /*
-	Code to request version of POD, Variax interface
-	(and maybe other devices).
-*/
+ * Code to request version of POD, Variax interface
+ * (and maybe other devices).
+ */
 static const char line6_request_version[] = {
 	0xf0, 0x7e, 0x7f, 0x06, 0x01, 0xf7
 };
 
 /*
-	 Class for asynchronous messages.
-*/
+ * Class for asynchronous messages.
+ */
 struct message {
 	struct usb_line6 *line6;
 	const char *buffer;
@@ -54,15 +54,15 @@ struct message {
 };
 
 /*
-	Forward declarations.
-*/
+ * Forward declarations.
+ */
 static void line6_data_received(struct urb *urb);
 static int line6_send_raw_message_async_part(struct message *msg,
 					     struct urb *urb);
 
 /*
-	Start to listen on endpoint.
-*/
+ * Start to listen on endpoint.
+ */
 static int line6_start_listen(struct usb_line6 *line6)
 {
 	int err;
@@ -91,16 +91,16 @@ static int line6_start_listen(struct usb_line6 *line6)
 }
 
 /*
-	Stop listening on endpoint.
-*/
+ * Stop listening on endpoint.
+ */
 static void line6_stop_listen(struct usb_line6 *line6)
 {
 	usb_kill_urb(line6->urb_listen);
 }
 
 /*
-	Send raw message in pieces of wMaxPacketSize bytes.
-*/
+ * Send raw message in pieces of wMaxPacketSize bytes.
+ */
 static int line6_send_raw_message(struct usb_line6 *line6, const char *buffer,
 				  int size)
 {
@@ -138,8 +138,8 @@ static int line6_send_raw_message(struct usb_line6 *line6, const char *buffer,
 }
 
 /*
-	Notification of completion of asynchronous request transmission.
-*/
+ * Notification of completion of asynchronous request transmission.
+ */
 static void line6_async_request_sent(struct urb *urb)
 {
 	struct message *msg = (struct message *)urb->context;
@@ -152,8 +152,8 @@ static void line6_async_request_sent(struct urb *urb)
 }
 
 /*
-	Asynchronously send part of a raw message.
-*/
+ * Asynchronously send part of a raw message.
+ */
 static int line6_send_raw_message_async_part(struct message *msg,
 					     struct urb *urb)
 {
@@ -196,8 +196,8 @@ static int line6_send_raw_message_async_part(struct message *msg,
 }
 
 /*
-	Setup and start timer.
-*/
+ * Setup and start timer.
+ */
 void line6_start_timer(struct timer_list *timer, unsigned long msecs,
 		       void (*function)(struct timer_list *t))
 {
@@ -207,8 +207,8 @@ void line6_start_timer(struct timer_list *timer, unsigned long msecs,
 EXPORT_SYMBOL_GPL(line6_start_timer);
 
 /*
-	Asynchronously send raw message.
-*/
+ * Asynchronously send raw message.
+ */
 int line6_send_raw_message_async(struct usb_line6 *line6, const char *buffer,
 				 int size)
 {
@@ -240,8 +240,8 @@ int line6_send_raw_message_async(struct usb_line6 *line6, const char *buffer,
 EXPORT_SYMBOL_GPL(line6_send_raw_message_async);
 
 /*
-	Send asynchronous device version request.
-*/
+ * Send asynchronous device version request.
+ */
 int line6_version_request_async(struct usb_line6 *line6)
 {
 	char *buffer;
@@ -260,8 +260,8 @@ int line6_version_request_async(struct usb_line6 *line6)
 EXPORT_SYMBOL_GPL(line6_version_request_async);
 
 /*
-	Send sysex message in pieces of wMaxPacketSize bytes.
-*/
+ * Send sysex message in pieces of wMaxPacketSize bytes.
+ */
 int line6_send_sysex_message(struct usb_line6 *line6, const char *buffer,
 			     int size)
 {
@@ -272,10 +272,10 @@ int line6_send_sysex_message(struct usb_line6 *line6, const char *buffer,
 EXPORT_SYMBOL_GPL(line6_send_sysex_message);
 
 /*
-	Allocate buffer for sysex message and prepare header.
-	@param code sysex message code
-	@param size number of bytes between code and sysex end
-*/
+ * Allocate buffer for sysex message and prepare header.
+ * @param code sysex message code
+ * @param size number of bytes between code and sysex end
+ */
 char *line6_alloc_sysex_buffer(struct usb_line6 *line6, int code1, int code2,
 			       int size)
 {
@@ -294,8 +294,8 @@ char *line6_alloc_sysex_buffer(struct usb_line6 *line6, int code1, int code2,
 EXPORT_SYMBOL_GPL(line6_alloc_sysex_buffer);
 
 /*
-	Notification of data received from the Line 6 device.
-*/
+ * Notification of data received from the Line 6 device.
+ */
 static void line6_data_received(struct urb *urb)
 {
 	struct usb_line6 *line6 = (struct usb_line6 *)urb->context;
@@ -344,8 +344,8 @@ static void line6_data_received(struct urb *urb)
 #define LINE6_READ_WRITE_MAX_RETRIES 50
 
 /*
-	Read data from device.
-*/
+ * Read data from device.
+ */
 int line6_read_data(struct usb_line6 *line6, unsigned address, void *data,
 		    unsigned datalen)
 {
@@ -415,8 +415,8 @@ int line6_read_data(struct usb_line6 *line6, unsigned address, void *data,
 EXPORT_SYMBOL_GPL(line6_read_data);
 
 /*
-	Write data to device.
-*/
+ * Write data to device.
+ */
 int line6_write_data(struct usb_line6 *line6, unsigned address, void *data,
 		     unsigned datalen)
 {
@@ -473,9 +473,9 @@ int line6_write_data(struct usb_line6 *line6, unsigned address, void *data,
 EXPORT_SYMBOL_GPL(line6_write_data);
 
 /*
-	Read Line 6 device serial number.
-	(POD, TonePort, GuitarPort)
-*/
+ * Read Line 6 device serial number.
+ * (POD, TonePort, GuitarPort)
+ */
 int line6_read_serial_number(struct usb_line6 *line6, u32 *serial_number)
 {
 	return line6_read_data(line6, 0x80d0, serial_number,
@@ -484,8 +484,8 @@ int line6_read_serial_number(struct usb_line6 *line6, u32 *serial_number)
 EXPORT_SYMBOL_GPL(line6_read_serial_number);
 
 /*
-	Card destructor.
-*/
+ * Card destructor.
+ */
 static void line6_destruct(struct snd_card *card)
 {
 	struct usb_line6 *line6 = card->private_data;
@@ -711,8 +711,8 @@ static int line6_init_cap_control(struct usb_line6 *line6)
 }
 
 /*
-	Probe USB device.
-*/
+ * Probe USB device.
+ */
 int line6_probe(struct usb_interface *interface,
 		const struct usb_device_id *id,
 		const char *driver_name,
@@ -802,8 +802,8 @@ int line6_probe(struct usb_interface *interface,
 EXPORT_SYMBOL_GPL(line6_probe);
 
 /*
-	Line 6 device disconnected.
-*/
+ * Line 6 device disconnected.
+ */
 void line6_disconnect(struct usb_interface *interface)
 {
 	struct usb_line6 *line6 = usb_get_intfdata(interface);
@@ -837,8 +837,8 @@ EXPORT_SYMBOL_GPL(line6_disconnect);
 #ifdef CONFIG_PM
 
 /*
-	Suspend Line 6 device.
-*/
+ * Suspend Line 6 device.
+ */
 int line6_suspend(struct usb_interface *interface, pm_message_t message)
 {
 	struct usb_line6 *line6 = usb_get_intfdata(interface);
@@ -859,8 +859,8 @@ int line6_suspend(struct usb_interface *interface, pm_message_t message)
 EXPORT_SYMBOL_GPL(line6_suspend);
 
 /*
-	Resume Line 6 device.
-*/
+ * Resume Line 6 device.
+ */
 int line6_resume(struct usb_interface *interface)
 {
 	struct usb_line6 *line6 = usb_get_intfdata(interface);
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index 6142559..b307944 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -45,8 +45,8 @@
 #endif
 
 /*
-	Line 6 MIDI control commands
-*/
+ * Line 6 MIDI control commands
+ */
 #define LINE6_PARAM_CHANGE   0xb0
 #define LINE6_PROGRAM_CHANGE 0xc0
 #define LINE6_SYSEX_BEGIN    0xf0
@@ -54,14 +54,14 @@
 #define LINE6_RESET          0xff
 
 /*
-	MIDI channel for messages initiated by the host
-	(and eventually echoed back by the device)
-*/
+ * MIDI channel for messages initiated by the host
+ * (and eventually echoed back by the device)
+ */
 #define LINE6_CHANNEL_HOST   0x00
 
 /*
-	MIDI channel for messages initiated by the device
-*/
+ * MIDI channel for messages initiated by the device
+ */
 #define LINE6_CHANNEL_DEVICE 0x02
 
 #define LINE6_CHANNEL_UNKNOWN 5	/* don't know yet what this is good for */
@@ -81,8 +81,8 @@ static const int SYSEX_DATA_OFS = sizeof(line6_midi_id) + 3;
 static const int SYSEX_EXTRA_SIZE = sizeof(line6_midi_id) + 4;
 
 /*
-	 Common properties of Line 6 devices.
-*/
+ * Common properties of Line 6 devices.
+ */
 struct line6_properties {
 	/* Card id string (maximum 16 characters).
 	 * This can be used to address the device in ALSA programs as
@@ -122,9 +122,9 @@ enum {
 };
 
 /*
-	 Common data shared by all Line 6 devices.
-	 Corresponds to a pair of USB endpoints.
-*/
+ * Common data shared by all Line 6 devices.
+ * Corresponds to a pair of USB endpoints.
+ */
 struct usb_line6 {
 	/* USB device */
 	struct usb_device *usbdev;
diff --git a/sound/usb/line6/midi.c b/sound/usb/line6/midi.c
index e2cf55c..092e226 100644
--- a/sound/usb/line6/midi.c
+++ b/sound/usb/line6/midi.c
@@ -25,8 +25,8 @@ static int send_midi_async(struct usb_line6 *line6, unsigned char *data,
 			   int length);
 
 /*
-	Pass data received via USB to MIDI.
-*/
+ * Pass data received via USB to MIDI.
+ */
 void line6_midi_receive(struct usb_line6 *line6, unsigned char *data,
 			int length)
 {
@@ -36,8 +36,8 @@ void line6_midi_receive(struct usb_line6 *line6, unsigned char *data,
 }
 
 /*
-	Read data from MIDI buffer and transmit them via USB.
-*/
+ * Read data from MIDI buffer and transmit them via USB.
+ */
 static void line6_midi_transmit(struct snd_rawmidi_substream *substream)
 {
 	struct usb_line6 *line6 =
@@ -70,8 +70,8 @@ static void line6_midi_transmit(struct snd_rawmidi_substream *substream)
 }
 
 /*
-	Notification of completion of MIDI transmission.
-*/
+ * Notification of completion of MIDI transmission.
+ */
 static void midi_sent(struct urb *urb)
 {
 	unsigned long flags;
@@ -101,10 +101,10 @@ static void midi_sent(struct urb *urb)
 }
 
 /*
-	Send an asynchronous MIDI message.
-	Assumes that line6->line6midi->lock is held
-	(i.e., this function is serialized).
-*/
+ * Send an asynchronous MIDI message.
+ * Assumes that line6->line6midi->lock is held
+ * (i.e., this function is serialized).
+ */
 static int send_midi_async(struct usb_line6 *line6, unsigned char *data,
 			   int length)
 {
@@ -255,8 +255,8 @@ static void snd_line6_midi_free(struct snd_rawmidi *rmidi)
 }
 
 /*
-	Initialize the Line 6 MIDI subsystem.
-*/
+ * Initialize the Line 6 MIDI subsystem.
+ */
 int line6_init_midi(struct usb_line6 *line6)
 {
 	int err;
diff --git a/sound/usb/line6/midibuf.c b/sound/usb/line6/midibuf.c
index 36a610b..251a80c 100644
--- a/sound/usb/line6/midibuf.c
+++ b/sound/usb/line6/midibuf.c
@@ -25,9 +25,9 @@ static int midibuf_message_length(unsigned char code)
 		message_length = length[(code >> 4) - 8];
 	} else {
 		/*
-		   Note that according to the MIDI specification 0xf2 is
-		   the "Song Position Pointer", but this is used by Line 6
-		   to send sysex messages to the host.
+		 * Note that according to the MIDI specification 0xf2 is
+		 * the "Song Position Pointer", but this is used by Line 6
+		 * to send sysex messages to the host.
 		 */
 		static const int length[] = { -1, 2, -1, 2, -1, -1, 1, 1, 1, 1,
 			1, 1, 1, -1, 1, 1
diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index b3854f8..20a2da3 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -97,8 +97,8 @@ static int snd_line6_impulse_period_put(struct snd_kcontrol *kcontrol,
 }
 
 /*
-	Unlink all currently active URBs.
-*/
+ * Unlink all currently active URBs.
+ */
 static void line6_unlink_audio_urbs(struct snd_line6_pcm *line6pcm,
 				    struct line6_pcm_stream *pcms)
 {
@@ -113,8 +113,8 @@ static void line6_unlink_audio_urbs(struct snd_line6_pcm *line6pcm,
 }
 
 /*
-	Wait until unlinking of all currently active URBs has been finished.
-*/
+ * Wait until unlinking of all currently active URBs has been finished.
+ */
 static void line6_wait_clear_audio_urbs(struct snd_line6_pcm *line6pcm,
 					struct line6_pcm_stream *pcms)
 {
@@ -455,8 +455,8 @@ static const struct snd_kcontrol_new line6_controls[] = {
 };
 
 /*
-	Cleanup the PCM device.
-*/
+ * Cleanup the PCM device.
+ */
 static void cleanup_urbs(struct line6_pcm_stream *pcms, int iso_buffers)
 {
 	int i;
@@ -511,8 +511,8 @@ static int snd_line6_new_pcm(struct usb_line6 *line6, struct snd_pcm **pcm_ret)
 }
 
 /*
-	Sync with PCM stream stops.
-*/
+ * Sync with PCM stream stops.
+ */
 void line6_pcm_disconnect(struct snd_line6_pcm *line6pcm)
 {
 	line6_unlink_audio_urbs(line6pcm, &line6pcm->out);
@@ -522,9 +522,9 @@ void line6_pcm_disconnect(struct snd_line6_pcm *line6pcm)
 }
 
 /*
-	Create and register the PCM device and mixer entries.
-	Create URBs for playback and capture.
-*/
+ * Create and register the PCM device and mixer entries.
+ * Create URBs for playback and capture.
+ */
 int line6_init_pcm(struct usb_line6 *line6,
 		   struct line6_pcm_properties *properties)
 {
diff --git a/sound/usb/line6/pcm.h b/sound/usb/line6/pcm.h
index bb0c9cb..acef244 100644
--- a/sound/usb/line6/pcm.h
+++ b/sound/usb/line6/pcm.h
@@ -10,8 +10,8 @@
  */
 
 /*
-	PCM interface to POD series devices.
-*/
+ * PCM interface to POD series devices.
+ */
 
 #ifndef PCM_H
 #define PCM_H
@@ -21,11 +21,11 @@
 #include "driver.h"
 
 /*
-	number of USB frames per URB
-	The Line 6 Windows driver always transmits two frames per packet, but
-	the Linux driver performs significantly better (i.e., lower latency)
-	with only one frame per packet.
-*/
+ * number of USB frames per URB
+ * The Line 6 Windows driver always transmits two frames per packet, but
+ * the Linux driver performs significantly better (i.e., lower latency)
+ * with only one frame per packet.
+ */
 #define LINE6_ISO_PACKETS	1
 
 /* in a "full speed" device (such as the PODxt Pro) this means 1ms,
@@ -36,37 +36,37 @@
 #define LINE6_IMPULSE_DEFAULT_PERIOD 100
 
 /*
-	Get substream from Line 6 PCM data structure
-*/
+ * Get substream from Line 6 PCM data structure
+ */
 #define get_substream(line6pcm, stream)	\
 		(line6pcm->pcm->streams[stream].substream)
 
 /*
-	PCM mode bits.
-
-	There are several features of the Line 6 USB driver which require PCM
-	data to be exchanged with the device:
-	*) PCM playback and capture via ALSA
-	*) software monitoring (for devices without hardware monitoring)
-	*) optional impulse response measurement
-	However, from the device's point of view, there is just a single
-	capture and playback stream, which must be shared between these
-	subsystems. It is therefore necessary to maintain the state of the
-	subsystems with respect to PCM usage.
-
-	We define two bit flags, "opened" and "running", for each playback
-	or capture stream.  Both can contain the bit flag corresponding to
-	LINE6_STREAM_* type,
-	  LINE6_STREAM_PCM = ALSA PCM playback or capture
-	  LINE6_STREAM_MONITOR = software monitoring
-	  IMPULSE = optional impulse response measurement
-	The opened flag indicates whether the buffer is allocated while
-	the running flag indicates whether the stream is running.
-
-	For monitor or impulse operations, the driver needs to call
-	line6_pcm_acquire() or line6_pcm_release() with the appropriate
-	LINE6_STREAM_* flag.
-*/
+ * PCM mode bits.
+ *
+ * There are several features of the Line 6 USB driver which require PCM
+ * data to be exchanged with the device:
+ * *) PCM playback and capture via ALSA
+ * *) software monitoring (for devices without hardware monitoring)
+ * *) optional impulse response measurement
+ * However, from the device's point of view, there is just a single
+ * capture and playback stream, which must be shared between these
+ * subsystems. It is therefore necessary to maintain the state of the
+ * subsystems with respect to PCM usage.
+ *
+ * We define two bit flags, "opened" and "running", for each playback
+ * or capture stream.  Both can contain the bit flag corresponding to
+ * LINE6_STREAM_* type,
+ * LINE6_STREAM_PCM = ALSA PCM playback or capture
+ * LINE6_STREAM_MONITOR = software monitoring
+ * IMPULSE = optional impulse response measurement
+ * The opened flag indicates whether the buffer is allocated while
+ * the running flag indicates whether the stream is running.
+ *
+ * For monitor or impulse operations, the driver needs to call
+ * line6_pcm_acquire() or line6_pcm_release() with the appropriate
+ * LINE6_STREAM_* flag.
+ */
 
 /* stream types */
 enum {
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index 819e9b2..674502c 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -20,8 +20,8 @@
 #include "playback.h"
 
 /*
-	Software stereo volume control.
-*/
+ * Software stereo volume control.
+ */
 static void change_volume(struct urb *urb_out, int volume[],
 			  int bytes_per_frame)
 {
@@ -64,8 +64,8 @@ static void change_volume(struct urb *urb_out, int volume[],
 }
 
 /*
-	Create signal for impulse response test.
-*/
+ * Create signal for impulse response test.
+ */
 static void create_impulse_test_signal(struct snd_line6_pcm *line6pcm,
 				       struct urb *urb_out, int bytes_per_frame)
 {
@@ -107,8 +107,8 @@ static void create_impulse_test_signal(struct snd_line6_pcm *line6pcm,
 }
 
 /*
-	Add signal to buffer for software monitoring.
-*/
+ * Add signal to buffer for software monitoring.
+ */
 static void add_monitor_signal(struct urb *urb_out, unsigned char *signal,
 			       int volume, int bytes_per_frame)
 {
@@ -132,15 +132,15 @@ static void add_monitor_signal(struct urb *urb_out, unsigned char *signal,
 	}
 
 	/*
-	   We don't need to handle devices with 6 bytes per frame here
-	   since they all support hardware monitoring.
+	 * We don't need to handle devices with 6 bytes per frame here
+	 * since they all support hardware monitoring.
 	 */
 }
 
 /*
-	Find a free URB, prepare audio data, and submit URB.
-	must be called in line6pcm->out.lock context
-*/
+ * Find a free URB, prepare audio data, and submit URB.
+ * must be called in line6pcm->out.lock context
+ */
 static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 {
 	int index;
@@ -211,8 +211,8 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 
 		if (line6pcm->out.pos + urb_frames > runtime->buffer_size) {
 			/*
-			   The transferred area goes over buffer boundary,
-			   copy the data to the temp buffer.
+			 * The transferred area goes over buffer boundary,
+			 * copy the data to the temp buffer.
 			 */
 			int len;
 
@@ -284,8 +284,8 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 }
 
 /*
-	Submit all currently available playback URBs.
-	must be called in line6pcm->out.lock context
+ * Submit all currently available playback URBs.
+ * must be called in line6pcm->out.lock context
  */
 int line6_submit_audio_out_all_urbs(struct snd_line6_pcm *line6pcm)
 {
@@ -301,8 +301,8 @@ int line6_submit_audio_out_all_urbs(struct snd_line6_pcm *line6pcm)
 }
 
 /*
-	Callback for completed playback URB.
-*/
+ * Callback for completed playback URB.
+ */
 static void audio_out_callback(struct urb *urb)
 {
 	int i, index, length = 0, shutdown = 0;
diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
index 020c818..80414ed 100644
--- a/sound/usb/line6/pod.c
+++ b/sound/usb/line6/pod.c
@@ -23,21 +23,21 @@
 #include "playback.h"
 
 /*
-	Locate name in binary program dump
-*/
+ * Locate name in binary program dump
+ */
 #define	POD_NAME_OFFSET 0
 #define	POD_NAME_LENGTH 16
 
 /*
-	Other constants
-*/
+ * Other constants
+ */
 #define POD_CONTROL_SIZE 0x80
 #define POD_BUFSIZE_DUMPREQ 7
 #define POD_STARTUP_DELAY 1000
 
 /*
-	Stages of POD startup procedure
-*/
+ * Stages of POD startup procedure
+ */
 enum {
 	POD_STARTUP_INIT = 1,
 	POD_STARTUP_VERSIONREQ,
@@ -185,8 +185,8 @@ static char *pod_alloc_sysex_buffer(struct usb_line6_pod *pod, int code,
 }
 
 /*
-	Process a completely received message.
-*/
+ * Process a completely received message.
+ */
 static void line6_pod_process_message(struct usb_line6 *line6)
 {
 	struct usb_line6_pod *pod = (struct usb_line6_pod *) line6;
@@ -216,8 +216,8 @@ static void line6_pod_process_message(struct usb_line6 *line6)
 }
 
 /*
-	Send system parameter (from integer).
-*/
+ * Send system parameter (from integer).
+ */
 static int pod_set_system_param_int(struct usb_line6_pod *pod, int value,
 				    int code)
 {
@@ -238,8 +238,8 @@ static int pod_set_system_param_int(struct usb_line6_pod *pod, int value,
 }
 
 /*
-	"read" request on "serial_number" special file.
-*/
+ * "read" request on "serial_number" special file.
+ */
 static ssize_t serial_number_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
@@ -250,8 +250,8 @@ static ssize_t serial_number_show(struct device *dev,
 }
 
 /*
-	"read" request on "firmware_version" special file.
-*/
+ * "read" request on "firmware_version" special file.
+ */
 static ssize_t firmware_version_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
@@ -263,8 +263,8 @@ static ssize_t firmware_version_show(struct device *dev,
 }
 
 /*
-	"read" request on "device_id" special file.
-*/
+ * "read" request on "device_id" special file.
+ */
 static ssize_t device_id_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
@@ -275,11 +275,11 @@ static ssize_t device_id_show(struct device *dev,
 }
 
 /*
-	POD startup procedure.
-	This is a sequence of functions with special requirements (e.g., must
-	not run immediately after initialization, must not run in interrupt
-	context). After the last one has finished, the device is ready to use.
-*/
+ * POD startup procedure.
+ * This is a sequence of functions with special requirements (e.g., must
+ * not run immediately after initialization, must not run in interrupt
+ * context). After the last one has finished, the device is ready to use.
+ */
 
 static void pod_startup1(struct usb_line6_pod *pod)
 {
@@ -390,8 +390,8 @@ static const struct snd_kcontrol_new pod_control_monitor = {
 };
 
 /*
-	POD device disconnected.
-*/
+ * POD device disconnected.
+ */
 static void line6_pod_disconnect(struct usb_line6 *line6)
 {
 	struct usb_line6_pod *pod = (struct usb_line6_pod *)line6;
@@ -401,8 +401,8 @@ static void line6_pod_disconnect(struct usb_line6 *line6)
 }
 
 /*
-	 Try to init POD device.
-*/
+ * Try to init POD device.
+ */
 static int pod_init(struct usb_line6 *line6,
 		    const struct usb_device_id *id)
 {
@@ -437,9 +437,9 @@ static int pod_init(struct usb_line6 *line6,
 		return err;
 
 	/*
-	   When the sound card is registered at this point, the PODxt Live
-	   displays "Invalid Code Error 07", so we do it later in the event
-	   handler.
+	 * When the sound card is registered at this point, the PODxt Live
+	 * displays "Invalid Code Error 07", so we do it later in the event
+	 * handler.
 	 */
 
 	if (pod->line6.properties->capabilities & LINE6_CAP_CONTROL) {
@@ -561,8 +561,8 @@ static const struct line6_properties pod_properties_table[] = {
 };
 
 /*
-	Probe USB device.
-*/
+ * Probe USB device.
+ */
 static int pod_probe(struct usb_interface *interface,
 		     const struct usb_device_id *id)
 {
diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index 36ed9c8..c91db46 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -308,8 +308,8 @@ static void podhd_disconnect(struct usb_line6 *line6)
 }
 
 /*
-	Try to init POD HD device.
-*/
+ * Try to init POD HD device.
+ */
 static int podhd_init(struct usb_line6 *line6,
 		      const struct usb_device_id *id)
 {
@@ -482,8 +482,8 @@ static const struct line6_properties podhd_properties_table[] = {
 };
 
 /*
-	Probe USB device.
-*/
+ * Probe USB device.
+ */
 static int podhd_probe(struct usb_interface *interface,
 		       const struct usb_device_id *id)
 {
diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index 750467f..ef0f591 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -272,11 +272,11 @@ static const struct snd_kcontrol_new toneport_control_source = {
 };
 
 /*
-	For the led on Guitarport.
-	Brightness goes from 0x00 to 0x26. Set a value above this to have led
-	blink.
-	(void cmd_0x02(byte red, byte green)
-*/
+ * For the led on Guitarport.
+ * Brightness goes from 0x00 to 0x26. Set a value above this to have led
+ * blink.
+ * (void cmd_0x02(byte red, byte green)
+ */
 
 static bool toneport_has_led(struct usb_line6_toneport *toneport)
 {
@@ -363,8 +363,8 @@ static bool toneport_has_source_select(struct usb_line6_toneport *toneport)
 }
 
 /*
-	Setup Toneport device.
-*/
+ * Setup Toneport device.
+ */
 static void toneport_setup(struct usb_line6_toneport *toneport)
 {
 	int ticks;
@@ -391,8 +391,8 @@ static void toneport_setup(struct usb_line6_toneport *toneport)
 }
 
 /*
-	Toneport device disconnected.
-*/
+ * Toneport device disconnected.
+ */
 static void line6_toneport_disconnect(struct usb_line6 *line6)
 {
 	struct usb_line6_toneport *toneport =
@@ -406,8 +406,8 @@ static void line6_toneport_disconnect(struct usb_line6 *line6)
 
 
 /*
-	 Try to init Toneport device.
-*/
+ * Try to init Toneport device.
+ */
 static int toneport_init(struct usb_line6 *line6,
 			 const struct usb_device_id *id)
 {
@@ -458,8 +458,8 @@ static int toneport_init(struct usb_line6 *line6,
 
 #ifdef CONFIG_PM
 /*
-	Resume Toneport device after reset.
-*/
+ * Resume Toneport device after reset.
+ */
 static int toneport_reset_resume(struct usb_interface *interface)
 {
 	toneport_setup(usb_get_intfdata(interface));
@@ -551,8 +551,8 @@ static const struct line6_properties toneport_properties_table[] = {
 };
 
 /*
-	Probe USB device.
-*/
+ * Probe USB device.
+ */
 static int toneport_probe(struct usb_interface *interface,
 			  const struct usb_device_id *id)
 {
diff --git a/sound/usb/line6/variax.c b/sound/usb/line6/variax.c
index e8c852b..ebfdc8a 100644
--- a/sound/usb/line6/variax.c
+++ b/sound/usb/line6/variax.c
@@ -23,8 +23,8 @@
 #define VARIAX_STARTUP_DELAY4 100
 
 /*
-	Stages of Variax startup procedure
-*/
+ * Stages of Variax startup procedure
+ */
 enum {
 	VARIAX_STARTUP_INIT = 1,
 	VARIAX_STARTUP_VERSIONREQ,
@@ -61,17 +61,17 @@ struct usb_line6_variax {
 #define VARIAX_OFFSET_ACTIVATE 7
 
 /*
-	This message is sent by the device during initialization and identifies
-	the connected guitar version.
-*/
+ * This message is sent by the device during initialization and identifies
+ * the connected guitar version.
+ */
 static const char variax_init_version[] = {
 	0xf0, 0x7e, 0x7f, 0x06, 0x02, 0x00, 0x01, 0x0c,
 	0x07, 0x00, 0x00, 0x00
 };
 
 /*
-	This message is the last one sent by the device during initialization.
-*/
+ * This message is the last one sent by the device during initialization.
+ */
 static const char variax_init_done[] = {
 	0xf0, 0x00, 0x01, 0x0c, 0x07, 0x00, 0x6b
 };
@@ -94,11 +94,11 @@ static void variax_activate_async(struct usb_line6_variax *variax, int a)
 }
 
 /*
-	Variax startup procedure.
-	This is a sequence of functions with special requirements (e.g., must
-	not run immediately after initialization, must not run in interrupt
-	context). After the last one has finished, the device is ready to use.
-*/
+ * Variax startup procedure.
+ * This is a sequence of functions with special requirements (e.g., must
+ * not run immediately after initialization, must not run in interrupt
+ * context). After the last one has finished, the device is ready to use.
+ */
 
 static void variax_startup1(struct usb_line6_variax *variax)
 {
@@ -171,8 +171,8 @@ static void variax_startup6(struct work_struct *work)
 }
 
 /*
-	Process a completely received message.
-*/
+ * Process a completely received message.
+ */
 static void line6_variax_process_message(struct usb_line6 *line6)
 {
 	struct usb_line6_variax *variax = (struct usb_line6_variax *) line6;
@@ -197,8 +197,8 @@ static void line6_variax_process_message(struct usb_line6 *line6)
 }
 
 /*
-	Variax destructor.
-*/
+ * Variax destructor.
+ */
 static void line6_variax_disconnect(struct usb_line6 *line6)
 {
 	struct usb_line6_variax *variax = (struct usb_line6_variax *)line6;
@@ -211,8 +211,8 @@ static void line6_variax_disconnect(struct usb_line6 *line6)
 }
 
 /*
-	 Try to init workbench device.
-*/
+ * Try to init workbench device.
+ */
 static int variax_init(struct usb_line6 *line6,
 		       const struct usb_device_id *id)
 {
@@ -280,9 +280,8 @@ static const struct line6_properties variax_properties_table[] = {
 };
 
 /*
-	Probe USB device.
-*/
+ * Probe USB device.
+ */
 static int variax_probe(struct usb_interface *interface,
 			const struct usb_device_id *id)
 {
--
2.7.4

