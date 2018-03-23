Return-Path: <Adam.Thomson.Opensource@diasemi.com>
X-Google-Smtp-Source: AG47ELtGxHQvXfigjJHlDU3SUHN/6eBjoZ8bISzK0rtOxgHQRdk8u5ne3p5SnXvbgI80M72R7tik
ARC-Seal: i=1; a=rsa-sha256; t=1521799948; cv=none;
        d=google.com; s=arc-20160816;
        b=fqR7YusK+6HIqOuUU/AI3NhrOP9BmwQQ4NSIqySV/xjuU8o8gHpcY9KIZnIoFAQj4w
         gnxZeE2F7zc7fQY3TKLbDJaQ+mSKvd0Q8FRhYjUfw9ezBEE6QFhmCoFOOoRTqpcLpTnS
         mbiku2XEEpCQOpFUJxPkGu93VUZ1s6iaKSaqNm/evNxEhA+uiyA7MmXquJBC/DN65zLF
         WdSlL2cnzU2z7sgZAy5U2aNKbkZWRCzk4xNDM86d7c9DARu9SC3nzNxsbjYkuojl2J4l
         SOMI8IZ4+IB3VhTZU4nPCpCjD6Me+OfPbY2DDOqL+zlGlkUxGFAU0PQHHFlRszjTzw9g
         BNNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:cc:to:subject:date:from:references:in-reply-to
         :message-id:arc-authentication-results;
        bh=Q9EB6baa63xHPnTWLBSNH6ZoDYSZ9OQ3ZRgMgWWF2qc=;
        b=V2Y8pOpHnjYlRjozbgi5xYCiYbWEjwPpUPjTEZTO8oiqZ8Io0kzAgOr3JwQ1/zgO7n
         d76vizQM1JwwU7MLSnjn1gMvElGgGV237Afuj9G/6NjtTzoU20OpJoYwu3yR0qKD9UZ3
         BF5Rb2xW1yvef4bvo2oKzh5eZMhX2+87/wlWEXpJ+4SpqPomG3n9XRABRSEwrfSPOBxY
         qrDeilIM2fYcpMu73/+TbTxTIZqg/xlmiQenygBA0BKcMwfs5ptEjY0XZprjrPwSEHAD
         PjWtG7lb1kR6+zPp2kkGiS8gMee9ZL39CgdYS52ic6RSYNmk1cLSakFlJH0TLovAIGb/
         DLhQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 193.109.254.105 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 193.109.254.105 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleJIrShJLcpLzFFi42KJ27nUWJf78pY
  ogwPnOC2aF69ns3hzfDqTRdfqnSwW1471Mllc3jWHzeJz7xFGi0XLWpktniw8w2RxeneJA6fH
  plWdbB7zTgZ67J+7ht1j47sdTB7v911l89j5vYHd4/MmuQD2KNbMvKT8igTWjPPH+hgLpllW7
  DnRyNLAOM2gi5GLQ0hgPaPE+z9nmLoYOYCcColrH2y7GDk5eAUyJTaue80KYnMKuEvce9kJVe
  ImsecTM0iYTcBCYvKJB2wgNouAqsSxw+fA4sICfhJbHjYxgYwXEXjPKPHp8QcWkASzQJ1E7++
  3LBDzBSVOznwCFZeQOPjiBVizkICBxOkFjWBxCQF7ienvrzKD7JUQ0JdoPBYLETaU+D7rG1SJ
  ucSsszvYJjAKzkIydRaSqQsYmVYxqhenFpWlFuma6SUVZaZnlOQmZuboGhqY6eWmFhcnpqfmJ
  CYV6yXn525iBMYHAxDsYJx3wv8QoyQHk5Iob+bxLVFCfEn5KZUZicUZ8UWlOanFhxhlODiUJH
  ivXQTKCRalpqdWpGXmACMVJi3BwaMkwssLkuYtLkjMLc5Mh0idYjTmuPHidRszR8OmVd3MQix
  5+XmpUuK8K0BKBUBKM0rz4AbBEsglRlkpYV5GoNOEeApSi3IzS1DlXzGKczAqCfN+A5nCk5lX
  ArfvFdApTECn+EwBO6UkESEl1cBY/aDapFCDLeMcR35CyvTOCfIPmqemBqfsvpFV7VHM6bLW0
  DBVlV2+nU/1tejiM36r9r3McPH5735sYusnl+KPa86dvLthzpqXnCmVnBeFjHmnTZI57rfpqb
  ijwGdrhSCXso/7drDOOD0z9GPsiX+NC/z99FpmVrulzFz5dcKS+EUvLq0wncekxFKckWioxVx
  UnAgANvs/ERsDAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-7.tower-193.messagelabs.com!1521799946!93415776!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Message-ID: <3750bdbd01434d4a6b0319a06eddda819272f604.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Fri, 23 Mar 2018 10:12:26 +0000
Subject: [PATCH v7 6/6] typec: tcpm: Add support for sink PPS related messages
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck
	<linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Jun
 Li <jun.li@nxp.com>
CC: <linux-usb@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 23/03/2018 08:40:00
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595722902060527093?=
X-GMAIL-MSGID: =?utf-8?q?1595722902060527093?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This commit adds sink side support for Get_Status, Status,
Get_PPS_Status and PPS_Status handling. As there's the
potential for a partner to respond with Not_Supported,
handling of this message is also added. Sending of
Not_Supported is added to handle messagescreceived but not
yet handled.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/usb/typec/tcpm.c | 143 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 134 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index 57a7d1a..7025a16 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -19,7 +19,9 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/usb/pd.h>
+#include <linux/usb/pd_ado.h>
 #include <linux/usb/pd_bdo.h>
+#include <linux/usb/pd_ext_sdb.h>
 #include <linux/usb/pd_vdo.h>
 #include <linux/usb/tcpm.h>
 #include <linux/usb/typec.h>
@@ -113,6 +115,11 @@
 	S(SNK_TRYWAIT_VBUS),			\
 	S(BIST_RX),				\
 						\
+	S(GET_STATUS_SEND),			\
+	S(GET_STATUS_SEND_TIMEOUT),		\
+	S(GET_PPS_STATUS_SEND),			\
+	S(GET_PPS_STATUS_SEND_TIMEOUT),		\
+						\
 	S(ERROR_RECOVERY),			\
 	S(PORT_RESET),				\
 	S(PORT_RESET_WAIT_OFF)
@@ -143,6 +150,7 @@ enum pd_msg_request {
 	PD_MSG_NONE = 0,
 	PD_MSG_CTRL_REJECT,
 	PD_MSG_CTRL_WAIT,
+	PD_MSG_CTRL_NOT_SUPP,
 	PD_MSG_DATA_SINK_CAP,
 	PD_MSG_DATA_SOURCE_CAP,
 };
@@ -1398,10 +1406,42 @@ static int tcpm_validate_caps(struct tcpm_port *port, const u32 *pdo,
 /*
  * PD (data, control) command handling functions
  */
+static inline enum tcpm_state ready_state(struct tcpm_port *port)
+{
+	if (port->pwr_role == TYPEC_SOURCE)
+		return SRC_READY;
+	else
+		return SNK_READY;
+}
 
 static int tcpm_pd_send_control(struct tcpm_port *port,
 				enum pd_ctrl_msg_type type);
 
+static void tcpm_handle_alert(struct tcpm_port *port, const __le32 *payload,
+			      int cnt)
+{
+	u32 p0 = le32_to_cpu(payload[0]);
+	unsigned int type = usb_pd_ado_type(p0);
+
+	if (!type) {
+		tcpm_log(port, "Alert message received with no type");
+		return;
+	}
+
+	/* Just handling non-battery alerts for now */
+	if (!(type & USB_PD_ADO_TYPE_BATT_STATUS_CHANGE)) {
+		switch (port->state) {
+		case SRC_READY:
+		case SNK_READY:
+			tcpm_set_state(port, GET_STATUS_SEND, 0);
+			break;
+		default:
+			tcpm_queue_message(port, PD_MSG_CTRL_WAIT);
+			break;
+		}
+	}
+}
+
 static void tcpm_pd_data_request(struct tcpm_port *port,
 				 const struct pd_message *msg)
 {
@@ -1489,6 +1529,14 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 			tcpm_set_state(port, BIST_RX, 0);
 		}
 		break;
+	case PD_DATA_ALERT:
+		tcpm_handle_alert(port, msg->payload, cnt);
+		break;
+	case PD_DATA_BATT_STATUS:
+	case PD_DATA_GET_COUNTRY_INFO:
+		/* Currently unsupported */
+		tcpm_queue_message(port, PD_MSG_CTRL_NOT_SUPP);
+		break;
 	default:
 		tcpm_log(port, "Unhandled data message type %#x", type);
 		break;
@@ -1571,6 +1619,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 		break;
 	case PD_CTRL_REJECT:
 	case PD_CTRL_WAIT:
+	case PD_CTRL_NOT_SUPP:
 		switch (port->state) {
 		case SNK_NEGOTIATE_CAPABILITIES:
 			/* USB PD specification, Figure 8-43 */
@@ -1690,12 +1739,75 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 			break;
 		}
 		break;
+	case PD_CTRL_GET_SOURCE_CAP_EXT:
+	case PD_CTRL_GET_STATUS:
+	case PD_CTRL_FR_SWAP:
+	case PD_CTRL_GET_PPS_STATUS:
+	case PD_CTRL_GET_COUNTRY_CODES:
+		/* Currently not supported */
+		tcpm_queue_message(port, PD_MSG_CTRL_NOT_SUPP);
+		break;
 	default:
 		tcpm_log(port, "Unhandled ctrl message type %#x", type);
 		break;
 	}
 }
 
+static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
+				    const struct pd_message *msg)
+{
+	enum pd_ext_msg_type type = pd_header_type_le(msg->header);
+	unsigned int data_size = pd_ext_header_data_size_le(msg->ext_msg.header);
+
+	if (!(msg->ext_msg.header && PD_EXT_HDR_CHUNKED)) {
+		tcpm_log(port, "Unchunked extended messages unsupported");
+		return;
+	}
+
+	if (data_size > PD_EXT_MAX_CHUNK_DATA) {
+		tcpm_log(port, "Chunk handling not yet supported");
+		return;
+	}
+
+	switch (type) {
+	case PD_EXT_STATUS:
+		/*
+		 * If PPS related events raised then get PPS status to clear
+		 * (see USB PD 3.0 Spec, 6.5.2.4)
+		 */
+		if (msg->ext_msg.data[USB_PD_EXT_SDB_EVENT_FLAGS] &
+		    USB_PD_EXT_SDB_PPS_EVENTS)
+			tcpm_set_state(port, GET_PPS_STATUS_SEND, 0);
+		else
+			tcpm_set_state(port, ready_state(port), 0);
+		break;
+	case PD_EXT_PPS_STATUS:
+		/*
+		 * For now the PPS status message is used to clear events
+		 * and nothing more.
+		 */
+		tcpm_set_state(port, ready_state(port), 0);
+		break;
+	case PD_EXT_SOURCE_CAP_EXT:
+	case PD_EXT_GET_BATT_CAP:
+	case PD_EXT_GET_BATT_STATUS:
+	case PD_EXT_BATT_CAP:
+	case PD_EXT_GET_MANUFACTURER_INFO:
+	case PD_EXT_MANUFACTURER_INFO:
+	case PD_EXT_SECURITY_REQUEST:
+	case PD_EXT_SECURITY_RESPONSE:
+	case PD_EXT_FW_UPDATE_REQUEST:
+	case PD_EXT_FW_UPDATE_RESPONSE:
+	case PD_EXT_COUNTRY_INFO:
+	case PD_EXT_COUNTRY_CODES:
+		tcpm_queue_message(port, PD_MSG_CTRL_NOT_SUPP);
+		break;
+	default:
+		tcpm_log(port, "Unhandled extended message type %#x", type);
+		break;
+	}
+}
+
 static void tcpm_pd_rx_handler(struct work_struct *work)
 {
 	struct pd_rx_event *event = container_of(work,
@@ -1736,7 +1848,9 @@ static void tcpm_pd_rx_handler(struct work_struct *work)
 				 "Data role mismatch, initiating error recovery");
 			tcpm_set_state(port, ERROR_RECOVERY, 0);
 		} else {
-			if (cnt)
+			if (msg->header & PD_HEADER_EXT_HDR)
+				tcpm_pd_ext_msg_request(port, msg);
+			else if (cnt)
 				tcpm_pd_data_request(port, msg);
 			else
 				tcpm_pd_ctrl_request(port, msg);
@@ -1797,6 +1911,9 @@ static bool tcpm_send_queued_message(struct tcpm_port *port)
 		case PD_MSG_CTRL_REJECT:
 			tcpm_pd_send_control(port, PD_CTRL_REJECT);
 			break;
+		case PD_MSG_CTRL_NOT_SUPP:
+			tcpm_pd_send_control(port, PD_CTRL_NOT_SUPP);
+			break;
 		case PD_MSG_DATA_SINK_CAP:
 			tcpm_pd_send_sink_caps(port);
 			break;
@@ -2483,14 +2600,6 @@ static inline enum tcpm_state hard_reset_state(struct tcpm_port *port)
 	return SNK_UNATTACHED;
 }
 
-static inline enum tcpm_state ready_state(struct tcpm_port *port)
-{
-	if (port->pwr_role == TYPEC_SOURCE)
-		return SRC_READY;
-	else
-		return SNK_READY;
-}
-
 static inline enum tcpm_state unattached_state(struct tcpm_port *port)
 {
 	if (port->port_type == TYPEC_PORT_DRP) {
@@ -3190,6 +3299,22 @@ static void run_state_machine(struct tcpm_port *port)
 		/* Always switch to unattached state */
 		tcpm_set_state(port, unattached_state(port), 0);
 		break;
+	case GET_STATUS_SEND:
+		tcpm_pd_send_control(port, PD_CTRL_GET_STATUS);
+		tcpm_set_state(port, GET_STATUS_SEND_TIMEOUT,
+			       PD_T_SENDER_RESPONSE);
+		break;
+	case GET_STATUS_SEND_TIMEOUT:
+		tcpm_set_state(port, ready_state(port), 0);
+		break;
+	case GET_PPS_STATUS_SEND:
+		tcpm_pd_send_control(port, PD_CTRL_GET_PPS_STATUS);
+		tcpm_set_state(port, GET_PPS_STATUS_SEND_TIMEOUT,
+			       PD_T_SENDER_RESPONSE);
+		break;
+	case GET_PPS_STATUS_SEND_TIMEOUT:
+		tcpm_set_state(port, ready_state(port), 0);
+		break;
 	case ERROR_RECOVERY:
 		tcpm_swap_complete(port, -EPROTO);
 		tcpm_pps_complete(port, -EPROTO);
-- 
1.9.1
